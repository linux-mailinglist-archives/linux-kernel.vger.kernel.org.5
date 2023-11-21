Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C5D7F37A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjKUUkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKUUkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:40:03 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03CD1BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:39:58 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cc3f5a9e96so1968207b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700599198; x=1701203998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gX/jHSjVMvQMuoAzLeVpINA8vcf/XXhZAAMF7Dr1Htw=;
        b=aOCGaQgVUQo1071NiL6+IclGxNl0CzP6bVNYSy4hLK8RetBCFFhT472KqD5kyB05VX
         teqbiboqAbslRIkKRe+R67k/7raJQBzgGb+tZYP0W2v8xTpsTpHNhtBDTtcovBhdsac/
         +tc2iJ1hGq6k+7iVNorThplXqANAJfJmI7a7PpUMHdeLQtqI9sm6cOhAYk9tu6JvklMT
         LH2n/Hc5yfyHQakYqNgMKHkxDR/z7B1Z7IBgUAsHftg8G9Pft3ESmAb4M1rjUbMgoKuS
         ZZYYdOKZzvx8OVAkVnnde8A/7YnKt4AuhgUKHeTU3bpTqyhyjdN08S5QsNkQqEMV2IkL
         6MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700599198; x=1701203998;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gX/jHSjVMvQMuoAzLeVpINA8vcf/XXhZAAMF7Dr1Htw=;
        b=DtI3lkHux54ACg0KLEq6P1/fxgpWkdaFoSmmWc7Ak9v2g5fTuiaynxuDMArfVLH76y
         Uk5uRj3uh7X5XyxoQbr6mICe7DR2rSaZdOtdVozxEG9u8CJJyuHx9L+Vy2+Sl9TPLyQP
         RNzTIMYIaiyQtca21u/UyyManYbuOXWiwLYC//nMNZoWt+JT2syiavHxlDi47PBg+NcH
         Ux7zP7ZjHUdLGQUxIhQ23QUrLiQoogh0Q2UqPV6nSHVCjMbsm6WhouiQR3BFZu2XCSHC
         A9gs3j5634sk8yRM1cImnirLGUdzio/nGXIbbjSURYVfPn4pUUpPGdoja7r0YmXwJ6sX
         HJpw==
X-Gm-Message-State: AOJu0Yw4nsmwxs0DhNhorUq+b6TXQUWIYHTFvcj2HGGn0jz+i8t+jY0S
        TK5o8yEphaSgRC3KlgZzDmTMH5lpe8qnDwo=
X-Google-Smtp-Source: AGHT+IELPIuKhD/YAdrhnQZvEYt7QZu6NUG23WB70IGl5qV4jBVbzdeQNxFjRT6VdyJMnCt2MVuVZg50EBBOzjE=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a81:4f84:0:b0:5ca:4a99:7008 with SMTP id
 d126-20020a814f84000000b005ca4a997008mr2821ywb.10.1700599198097; Tue, 21 Nov
 2023 12:39:58 -0800 (PST)
Date:   Tue, 21 Nov 2023 20:39:55 +0000
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637; i=rdbabiera@google.com;
 h=from:subject; bh=g3cATdDr31eccLe03DHQgAdZzg53ANBo3tzI1LoDz8E=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmxorMqPUL6W6ov9tm+8mlYddhft0n+7cGy60HTA+QE7
 85IsPjYUcrCIMbBICumyKLrn2dw40rqljmcNcYwc1iZQIYwcHEKwETihRkZei2t3rbxzJb1zuep
 fqkQnLblpNvN43v2m3JyJufs+BmwnJHh796Q47Xak7i22gczPVD9yffhSs+uPzFrvBLtF3Lyzc1 iBQA=
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231121203954.173364-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: class: fix typec_altmode_put_partner to put plugs
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, RD Babiera <rdbabiera@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When releasing an Alt Mode, typec_altmode_release called by a plug device
will not release the plug Alt Mode, meaning that a port will hold a
reference to a plug Alt Mode even if the port partner is unregistered.
As a result, typec_altmode_get_plug() can return an old plug altmode.

Currently, typec_altmode_put_partner does not raise issues
when unregistering a partner altmode. Looking at the current
implementation:

> static void typec_altmode_put_partner(struct altmode *altmode)
> {
>	struct altmode *partner = altmode->partner;

When called by the partner Alt Mode, then partner evaluates to the port's
Alt Mode. When called by the plug Alt Mode, this also evaluates to the
port's Alt Mode.

>	struct typec_altmode *adev;
>
>	if (!partner)
>		return;
>
>	adev = &partner->adev;

This always evaluates to the port's typec_altmode

>	if (is_typec_plug(adev->dev.parent)) {
>		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
>
>		partner->plug[plug->index] = NULL;

If the routine is called to put the plug's Alt mode and altmode refers to
the plug, then adev referring to the port can never be a typec_plug. If
altmode refers to the port, adev will always refer to the port partner,
which runs the block below.

>	} else {
>		partner->partner = NULL;
>	}
>	put_device(&adev->dev);
> }

When calling typec_altmode_set_partner, a registration always calls
get_device() on the port partner or the plug being registered, therefore
typec_altmode_put_partner should put_device() the same device. By changing
adev to altmode->adev, we make sure to put the correct device and properly
unregister plugs. The reason port partners are always properly
unregistered is because even when adev refers to the port, the port
partner gets nullified in the else block. The port device currently gets
put().

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 2e0451bd336e..803be1943445 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -267,7 +267,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	if (!partner)
 		return;
 
-	adev = &partner->adev;
+	adev = &altmode->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.43.0.rc1.413.gea7ed67945-goog

