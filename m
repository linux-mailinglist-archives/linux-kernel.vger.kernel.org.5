Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756807DEF44
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345947AbjKBJy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjKBJyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:54:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F16133
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:54:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso110292066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698918888; x=1699523688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYS16eCPsBztvO6TV3MQMioFM+kthtA6Q+ME42940KY=;
        b=MOGJ4NAJbyDjOO8tgJKz4GJY3se8B9zCsiPAI5qbJVO9bhoOrbG8Ekj6tyeGJQSsea
         S53CCL61GeJeQ1rFAmyr3QyIDIkYt3/MtKqF2qjtAinF/HrbbBm0gcSzYg2N2f5Nwiei
         VZ+jRpapOyAA8t38fLuB50IAG6W7QZmRlwQZ+PZWOFXBydrtovMHe5etVzrg1q0raP6F
         XrrmMjb+u6I02pbFdA8Wuhdj0UqxoSQzpBIEKEpSBA4uV0N4OT0BPsoH+H9tKI0+7Vka
         euvVfEl2gutOE7ZAPPLDl2l5JLBcyybVmtY67DRdxot1I6PE8buQJ+nh441C/RefsWhi
         0uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698918888; x=1699523688;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYS16eCPsBztvO6TV3MQMioFM+kthtA6Q+ME42940KY=;
        b=sUX0H04zHLiHZhfRa+QtBgjmjxmTKdjYbEMyof8/x+7veOkLZXzOWjsy6C1EShM2RT
         +FShq4dvy4nc99mVNtGGlQFy1/aZIGMQwixCmnDdpltk9+byLZ3Z2fV4vEZWiI+uwTKv
         popDBXPHCua/2Yb4Z5BJ80QCfTfe7kBQZXRVpToWgvEUh7YZYyC+ggjtf9OJa6BLMw9F
         ZcC3+aJr/W56TmZKdBbBxjPKxti8ov8EWSlX2J3ELemNfk1c4SzOgB2Wcp1fMGZCSA8w
         AD8WCxFGZcTbZuU5HOAqJzT6haPS5gZUfdlkJq+WtXY+cLwWO4GlzEAwpSu+hlPx2TTx
         bt1g==
X-Gm-Message-State: AOJu0YwfQANYVAU2aEqQBSTqNKdF6QV6D7JpjnmkUZcSwElAJYNwOoYG
        X86IAXL3dhJT8QfEJuhGXPvT2A6eSXEMI0PUzobU4f1g
X-Received: by 2002:a17:907:724e:b0:9be:5ab2:73c0 with SMTP id
 ds14-20020a170907724e00b009be5ab273c0mt4010139ejc.8.1698918888378; Thu, 02
 Nov 2023 02:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231102075853.1320710-1-xinglong.yang@cixtech.com>
In-Reply-To: <20231102075853.1320710-1-xinglong.yang@cixtech.com>
From:   sean yang <seanyang230@gmail.com>
Date:   Thu, 2 Nov 2023 17:54:37 +0800
Message-ID: <CADGqjFKS9ytGOdvrcr=JuggRFW_1bgLVn-EJTbjoa4wSwgNhHQ@mail.gmail.com>
Subject: Fwd: [PATCH v2] firmware: arm_scmi: Refrain set operations of perf
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MALFORMED_FREEMAIL,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A xinglong.yang <seanyang230@gmail.com>
Date: 2023=E5=B9=B411=E6=9C=882=E6=97=A5=E5=91=A8=E5=9B=9B 15:59
Subject: [PATCH v2] firmware: arm_scmi: Refrain set operations of perf
To: <xinglong.yang@cixtech.com>, <sudeep.holla@arm.com>,
<cristian.marussi@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>


Refrain from trying to take the SET operation where the set_* operations
are not supported, because: (1.) avoid unneeded SCMI exchanges, (2.)
avoids to trust the FW reply blindly.

Signed-off-by: xinglong.yang <xinglong.yang@cixtech.com>
---
 drivers/firmware/arm_scmi/perf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/p=
erf.c
index 431bda9165c3..3bcdef91ed5c 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -377,6 +377,9 @@ static int scmi_perf_limits_set(const struct
scmi_protocol_handle *ph,
        if (IS_ERR(dom))
                return PTR_ERR(dom);

+       if (!dom->set_limits)
+               return -EOPNOTSUPP;
+
        if (PROTOCOL_REV_MAJOR(pi->version) >=3D 0x3 && !max_perf && !min_p=
erf)
                return -EINVAL;

@@ -473,6 +476,9 @@ static int scmi_perf_level_set(const struct
scmi_protocol_handle *ph,
        if (IS_ERR(dom))
                return PTR_ERR(dom);

+       if (!dom->set_perf)
+               return -EOPNOTSUPP;
+
        if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr) {
                struct scmi_fc_info *fci =3D &dom->fc_info[PERF_FC_LEVEL];

--
2.42.0
