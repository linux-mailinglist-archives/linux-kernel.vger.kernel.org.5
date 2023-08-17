Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79132780005
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355377AbjHQVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355337AbjHQVjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF403E74
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692308310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aeAopVzD568TVshxf9B8QDlIPyA5uq6/h2SsMX6bHOQ=;
        b=CFhgXKts+Ypz/MzKdSKjw+vnfUTzIYx6B4WhQrZvUofQcIecqbHSOXmWQFbz9CbEKEaG3+
        +uomjf6+KliTDm08Km9YkLPeLl2txSHpokmAxZRTVJEM8/QWz7kuN60ElrVQIGJeJ6OVF4
        aEbAKqFI/jNl/ImqxL2VxPnikxZgzT4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-oMPd7ZcSNWy54u20CFzFVg-1; Thu, 17 Aug 2023 17:38:28 -0400
X-MC-Unique: oMPd7ZcSNWy54u20CFzFVg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a831831118so245868b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692308307; x=1692913107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeAopVzD568TVshxf9B8QDlIPyA5uq6/h2SsMX6bHOQ=;
        b=LF6VFn0cmjbeC6oldQvA3oo9Nqajx1b6/PYcVVsIW0e5bSUPQTzau+2Sfb/irHd1oF
         65FdTLD8cMJ7BJu99XJtS/m1gzVAKN39zBEbBTuHQMFridoUD9/byFmDZnn+hp4AWKUi
         4om1dnfbeRjJp2zlpmIh8jBCZok64UsvB5kpK1CN9r8+0yE4sAOK+LtlDOfHORtv3c8o
         BVKzvZij5oshwdMQTaFjua+a/U2BOeLCe8lWY996WMi8d9+UKbGzYHlFkRciDlCnYgLy
         oZUcSpEjiv5TxSiP6VrnjTzD30TPuaJ4fXzWWcRxUFRvnLKe5Yt6cEQDzXI6m+Sc2FiZ
         AXzg==
X-Gm-Message-State: AOJu0YysWA1NHCqGtNVB91VbmjcbyKcMaFv/E4ZPcd+AdhP7+na50+zB
        7ltENptFq2jh+/TgzJj5cYq7TgpA5QoWYnbCfB13mMHZXWC3dsgt04gRbKjDdTVr6I2icJskDbJ
        OVMw3/5tV8TYpt5G00TLe4mR7
X-Received: by 2002:a05:6808:171c:b0:3a7:2c8c:349b with SMTP id bc28-20020a056808171c00b003a72c8c349bmr921235oib.37.1692308307140;
        Thu, 17 Aug 2023 14:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPJW5TfwkgDsetnCbBa55QOOVFPM3Uo3yM8WAhR01KBK1NSTXWbo9Z4qrLH7/MW3ZAkV0ooA==
X-Received: by 2002:a05:6808:171c:b0:3a7:2c8c:349b with SMTP id bc28-20020a056808171c00b003a72c8c349bmr921222oib.37.1692308306900;
        Thu, 17 Aug 2023 14:38:26 -0700 (PDT)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id s1-20020ae9f701000000b0076c71c1d2f5sm96547qkg.34.2023.08.17.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:38:26 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@bgdev.pl,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 0/2] sa8775p-ride: Describe ethernet phy IRQs
Date:   Thu, 17 Aug 2023 16:37:15 -0500
Message-ID: <20230817213815.638189-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the hardware can detect the IRQs, let's describe them instead
of polling the phys

Andrew Halaney (2):
  arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy0 irq
  arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy1 irq

 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.41.0

