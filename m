Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34B77B38ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjI2R1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbjI2R00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:26:26 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDBE1BC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:12 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57b6a7e0deeso7197773eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008371; x=1696613171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FmPWGFXlzm/HpDO5LhkisvPrSRbK6I07Ofe/Ps9MCc=;
        b=T7+ZOeJGFZ8QNiMdX3tgooVzkUHmRUu7PEEqFnfe32Jzxm8us/XFrDjHxwKbyooXqN
         0FCDWa40QV9dDK1RV8gmldksG9DUHN7twRk6KBQWwAoFjb3Xu43GpKsa7hFBDOZB2sM8
         5kIzBzaE1f39tlS2A3gsznRU5eeVnGAfh8v5jqsEXZjM2+5YQ8ELbTBh8eQ3ZSEhPZOB
         3knqF3h2HPF2s7FYcQ930hWEnVmkHMCDsZtfTMb6GxwWfQ6wIjx7ESLCe2wEc0SnYW3G
         TC/AIpMNzVcp88ZevCmnpBdD9cD4TsROuAUUHSnsEs8UaUTZ0K3MVOBZO4TlVP55EMjc
         HRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008371; x=1696613171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FmPWGFXlzm/HpDO5LhkisvPrSRbK6I07Ofe/Ps9MCc=;
        b=CdpECST6t2uAS/72OtorBZJIGkMYi+aMognDDc/3++xij4k0fTqWBhstOUzR98HTXi
         GFredqcfKe+FNQ3dHLRHCiAAUx5fZVVd45BJRN1iwNaWW5CCrca0HmpfkePi8GvQIJNg
         rB8yXbaZtk111YKtavhkIJi7ui19cPbB274tMNqbgnhgjM4k15gxtwnqiF83cLZwooDn
         UZGebJpg04MoQTWh4jlEeQNNW9fWWAPl9oIXFf6n6OMO23O+72G5oRCO3EHvcXcOFtio
         vxDJ0KZIushmbSug0zrQOc924br9bT9V5TwXlZF1RmmirGRwpqB/IKueG4mdI8pyfK6S
         0Ing==
X-Gm-Message-State: AOJu0Yy3gTTJE5XqjqGSUFgznwMclSCTHla87jVZwkhM3DCjp64ltH+C
        MHL0SxrsfB8+LspqxN9brFHvaQ==
X-Google-Smtp-Source: AGHT+IGo8C13uUAx61E4DnW+F1vNgvyWsHBigt0nkOjFX5gCz6fiLgXMlerkCV5kZCgq3+GpEGMKnA==
X-Received: by 2002:a4a:ea28:0:b0:57b:eee7:4a40 with SMTP id y8-20020a4aea28000000b0057beee74a40mr5161864ood.7.1696008371561;
        Fri, 29 Sep 2023 10:26:11 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:26:11 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 27/27] staging: iio: resolver: ad2s1210: add label attribute support
Date:   Fri, 29 Sep 2023 12:23:32 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-27-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

The ad2s1210 resolver driver has quite a few channels, mostly for
internal signals for event support. This makes it difficult to know
which channel is which. This patch adds a label attribute to the
channels to make it easier to identify them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes: This is a new patch in v3

 drivers/staging/iio/resolver/ad2s1210.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index dc3cc3ab855e..a187fa07d315 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -1106,6 +1106,34 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	return ret;
 }
 
+static int ad2s1210_read_label(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       char *label)
+{
+	if (chan->type == IIO_ANGL) {
+		if (chan->channel == 0)
+			return sprintf(label, "position\n");
+		if (chan->channel == 1)
+			return sprintf(label, "tracking error\n");
+	}
+	if (chan->type == IIO_ANGL_VEL)
+		return sprintf(label, "velocity\n");
+	if (chan->type == IIO_PHASE)
+		return sprintf(label, "synthetic reference\n");
+	if (chan->type == IIO_ALTVOLTAGE) {
+		if (chan->output)
+			return sprintf(label, "excitation\n");
+		if (chan->channel == 0)
+			return sprintf(label, "monitor signal\n");
+		if (chan->channel == 1 && chan->channel2 == IIO_MOD_X)
+			return sprintf(label, "cosine\n");
+		if (chan->channel == 1 && chan->channel2 == IIO_MOD_Y)
+			return sprintf(label, "sine\n");
+	}
+
+	return -EINVAL;
+}
+
 static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -1256,6 +1284,7 @@ static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
 	.read_avail = ad2s1210_read_avail,
 	.write_raw = ad2s1210_write_raw,
+	.read_label = ad2s1210_read_label,
 	.attrs = &ad2s1210_attribute_group,
 	.read_event_value = ad2s1210_read_event_value,
 	.write_event_value = ad2s1210_write_event_value,

-- 
2.42.0

