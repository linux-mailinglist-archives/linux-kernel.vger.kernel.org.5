Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259676C96D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjHBJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjHBJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:25:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3506AE7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:25:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so85898451fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20221208.gappssmtp.com; s=20221208; t=1690968308; x=1691573108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w6+LT5AnXJWqsBFrgMPzoYnhOomhM/UwugjIu3qBxMM=;
        b=39a6Q/vaKN8itJqe0SnYz5BpgwVJjKra/huKGTY9PvFtAMZuDYJIJ7gDjPXur8DQ4Y
         HhHzvtk53fS7HAS6ZQG3BeW/4hXHlRHgnIyuSZ7opHsk6n3WkF4hKHCixK+DhgjNmr5V
         xtKcaSKwDOsSEsyyV6LZePEwOzFCMnmNslOLs8tCZmQElBtxZiCgbUhZxtRTCd2yqUFJ
         7d3ZYk54Aan2B3RuF9diYg91GhaKOdo5gWyqyUEPuml8YcvGPHJmC8GE0ES31XO3AZHF
         Biz93nKubVj1wVVGVqgR4BhLgFWD+iQQ5RGF0QVTVK6LnWDFA2/MM4gU1jTIyNANXUrs
         UrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690968308; x=1691573108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6+LT5AnXJWqsBFrgMPzoYnhOomhM/UwugjIu3qBxMM=;
        b=Fqj6+VPR8FWAc36bDS5b6H8kkovAI+8g/mnDiOHBqQELA9Lr+MSnHxDQxT5cC2WpFN
         1OttV6xrTo3UnYewk79xqxIoYdH555xG/WSCcm5kilRPdATonOW0KpWtBmdXPIFJ6iLn
         cN0l6M/otCfVC3iBN4a2O4LhBZw5PGZBYRaShXEsJNyJcZon3AGfshOxdkEtTBpXive4
         AfC14WUIhrkMOUEd5mSfO9jhtTbrp6c0nNnSXCxaV/L0fQdQfmogGRkJi44Cywk8z3vB
         a2e3bAeR6gxwsSN2EZFz5PCJcBqc07g0FGaH2jAgcJm7Rk6uw97U9iHJc1vdZvS55xMw
         5eDQ==
X-Gm-Message-State: ABy/qLawwiKYDh2BTWRi+fsOtg3ei4aCborUqe0C6tXRuUt0MXtnGmHA
        8LWqYdl0GABPHWvaFm3nu2kf+45xltoct7UR96zm7e6VsS/lxJHZu+JvXgAaUdKMExnQP/kewTz
        znRs+01NJ2gGpQ/bsqG4b19Zzif/mWZ2FQQ==
X-Google-Smtp-Source: APBJJlFDRnTyap4fSmGp05DOOvvuyDmRWQi1MlOW0KAriUKx005/o4JVevyoooLIxdWg+WuGBepv2g==
X-Received: by 2002:a2e:9049:0:b0:2b6:c61c:745b with SMTP id n9-20020a2e9049000000b002b6c61c745bmr4599283ljg.3.1690968308366;
        Wed, 02 Aug 2023 02:25:08 -0700 (PDT)
Received: from localhost (dslb-088-076-253-094.088.076.pools.vodafone-ip.de. [88.76.253.94])
        by smtp.gmail.com with ESMTPSA id l7-20020a1c7907000000b003fbb5506e54sm1136084wme.29.2023.08.02.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:25:07 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@bisdn.de>
To:     Taras Chornyi <taras.chornyi@plvision.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vadym Kochan <vkochan@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] prestera: fix fallback to previous version on same major version
Date:   Wed,  2 Aug 2023 11:23:56 +0200
Message-ID: <20230802092357.163944-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both supported and previous version have the same major version,
and the firmwares are missing, the driver ends in a loop requesting the
same (previous) version over and over again:

    [   76.327413] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
    [   76.339802] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.352162] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.364502] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.376848] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.389183] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.401522] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.413860] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    [   76.426199] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
    ...

Fix this by inverting the check to that we aren't yet at the previous
version, and also check the minor version.

This also catches the case where both versions are the same, as it was
after commit bb5dbf2cc64d ("net: marvell: prestera: add firmware v4.0
support").

With this fix applied:

    [   88.499622] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/m=
vsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
    [   88.511995] Prestera DX 0000:01:00.0: failed to request previous fir=
mware: mrvl/prestera/mvsw_prestera_fw-v4.0.img
    [   88.522403] Prestera DX: probe of 0000:01:00.0 failed with error -2

Fixes: 47f26018a414 ("net: marvell: prestera: try to load previous fw versi=
on")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
 drivers/net/ethernet/marvell/prestera/prestera_pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers=
/net/ethernet/marvell/prestera/prestera_pci.c
index f328d957b2db..35857dc19542 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -727,7 +727,8 @@ static int prestera_fw_get(struct prestera_fw *fw)
=20
 	err =3D request_firmware_direct(&fw->bin, fw_path, fw->dev.dev);
 	if (err) {
-		if (ver_maj =3D=3D PRESTERA_SUPP_FW_MAJ_VER) {
+		if (ver_maj !=3D PRESTERA_PREV_FW_MAJ_VER ||
+		    ver_min !=3D PRESTERA_PREV_FW_MIN_VER) {
 			ver_maj =3D PRESTERA_PREV_FW_MAJ_VER;
 			ver_min =3D PRESTERA_PREV_FW_MIN_VER;
=20
--=20
2.41.0


--=20
BISDN GmbH
K=F6rnerstra=DFe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=F6psel


Commercial register:=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=A0DE283257294

