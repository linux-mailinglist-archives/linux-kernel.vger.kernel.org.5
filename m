Return-Path: <linux-kernel+bounces-85505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D786B6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1581A2891A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8D79B95;
	Wed, 28 Feb 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="F37x/wC4"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DF79B74;
	Wed, 28 Feb 2024 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143606; cv=none; b=gg4kvLdVFNyyYInlOTvcw4w0hM89xpjOVpA7Rj1wX81+Yo8DggJLxnUcKmX3209vPRyfdFWalRJC9V9E782rvWOn8UuRpn28LlymCF60V2MvRvntggSB/8viIcixgRIZTu/nD3LTFikNKWSxhHHe4fpd0VLS7NGwnJlj3o3/8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143606; c=relaxed/simple;
	bh=ZR1gVUOsggkAbfdG+ftQUzWOijBHNwcEyXHlrDPii78=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=k9c6l4xuAlTzlm9Hx5CSnR6cWGdViJD2MO93wq36vhOb2P+E/3oP15wbMBnapfMoQexqPHzqJnGK29YUIFVb/mfpo0gYVtMFBtDcVOi8qZSgfCkYt7KIpoDONhMbEBwFHDPdCOFTEwtZDmdRmwlE1UqYYOG3jOT0vN3BmXYriZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=F37x/wC4; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709143545; x=1709748345; i=markus.elfring@web.de;
	bh=ZR1gVUOsggkAbfdG+ftQUzWOijBHNwcEyXHlrDPii78=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=F37x/wC4sz0BlmrhNfGJbY9QYfbgCDdECqjqmR8+Qgp/aZlE6TkMN0GKa0JQr8bu
	 pYx47w4r5lrX51LBu9srNhahzoPMPe3wHn8qNqSpW1y5ORydxTTAf1l0eBc5PHIVF
	 SQlleuUC4sPtHNWeQ72+4Wh3OGjvGLod8ZdiDAAPMFejtSwurcoJ8UJ1MN7PetcWL
	 GNPVrTGoNcGhQhr2hACgMHHzvNqvcOMx6vzcTDMwB4PYJEWxJ4F58gFAerQImuilL
	 1HSgJSqDfBTrLnqaQ5MJ4zuN38guPhVSrm9IDQWEk+g0DZ5cRcC4+rvcsK5hICj2O
	 jaD+9dM6n2hxzXGFbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01di-1qiar90csg-00x4Um; Wed, 28
 Feb 2024 19:05:45 +0100
Message-ID: <29b63eb4-2342-4ca8-a313-5de2a6ec6a83@web.de>
Date: Wed, 28 Feb 2024 19:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Johan Hovold <johan+linaro@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Clark <robdclark@gmail.com>,
 Robert Foss <rfoss@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] soc: qcom: pmic_glink_altmode: Use common error handling code
 in pmic_glink_altmode_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVTWRcYqGqMfooiCzODDDLdvq1YXrP76vl9kG0CgTTVleNhkQhp
 qMdM5H805+s5j4I3CO1Wy5IjM69/xBbwSgtYSBUhQq00nyLv3gXYz0twA9bbkDxf3NFWHiQ
 dBmYZhQAv5/kDZuLudY3jIvffAQ+qU3P5hDwV/0c6vruwCo+elms0rU7L2BLdDW4b+l+Dbh
 +2WWF0u/kir9+uMIRlzeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CPX/jO7+ewY=;yhID4ONoDIwnFO6yGSsnbKFCn7H
 bTQNfvnLitKYrhPfC12En+H8iIpWoA8Ja+6RHQN+BzYzevX6jW+NjUp/I/Lpnt3V2aESDDlgc
 BhrM9j2NJ55Ag2RVNBzTSzFxo88yrcB6wFKOcp3Py+NHR3I0eB4SbfUSZKXgSrLAjRzrwP1yT
 nJ+RmDCiwlW7cB4dYtJujO3fk3DCxUJ66cLwLBC+0CIZRJdQPnlONmmBxfY7wuLft+wfCV2EC
 XNq0LZwRYdsTsrs4JDwhyRE+vROGlBYxlYiNgXOE7fPSxwDpuA+pEiU/cydWdi+ao7UKKPDUo
 1keFkGa0D0DHm2TnyfZ0CGD4sxw8MwvsS8nyYviz4kjBp244XYuUav9Bl0hHVfpRm8xfMoSVa
 ZATms1bl1ZQRCisunCU1bXIPjJb2X3kmomFiVcO7JGZEvKDr6NLqDTDyUYKnnearTHUper6/F
 TdCzeCHwBwO2V7dak5MLM1zsSTvLcEWdRpO0ejwQo1Cho/FWkPlvaXZCmMZ+2z/c1ln4ffVKN
 +xpHFG6yQSEKRXg/TogbD6B17BHcq0o6ZDxp5ePwzVtJHBPaDqp17CZOWriV5xzE1bnb1LYU4
 4zLvIayVtGfYVFXs/XrVxZ0Fa2EvrwDVoEqBOpifHgWGWsVeWbi+lEydRtmw12DKHvGJg5AR9
 HhBpDyHF4WVKWJ2rOvg5FyCGYV7ySI6vSk5hWWx8pMA7fLPYQrRJ5rD050t5a84zAv4XYKcxe
 lSprAcdmzK0et8zDKJnz3Vx6huNxi8w163dQf2WYJ013Aycrxu0zBtZTFH8H87o1Yuq9sDIYX
 Xul8XmKrL6TEi1s/welcuEwC7JcgGf6QxjbvfNqJWaoHE=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 28 Feb 2024 18:45:13 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/qcom/pmic_glink_altmode.c | 57 +++++++++++++--------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic=
_glink_altmode.c
index b3808fc24c69..c987a45e1703 100644
=2D-- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -434,8 +434,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_d=
evice *adev,
 		ret =3D fwnode_property_read_u32(fwnode, "reg", &port);
 		if (ret < 0) {
 			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
-			fwnode_handle_put(fwnode);
-			return ret;
+			goto put_fwnode;
 		}

 		if (port >=3D ARRAY_SIZE(altmode->ports)) {
@@ -445,8 +444,8 @@ static int pmic_glink_altmode_probe(struct auxiliary_d=
evice *adev,

 		if (altmode->ports[port].altmode) {
 			dev_err(dev, "multiple connector definition for port %u\n", port);
-			fwnode_handle_put(fwnode);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			goto put_fwnode;
 		}

 		alt_port =3D &altmode->ports[port];
@@ -456,8 +455,8 @@ static int pmic_glink_altmode_probe(struct auxiliary_d=
evice *adev,

 		alt_port->bridge =3D devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnod=
e));
 		if (IS_ERR(alt_port->bridge)) {
-			fwnode_handle_put(fwnode);
-			return PTR_ERR(alt_port->bridge);
+			ret =3D PTR_ERR(alt_port->bridge);
+			goto put_fwnode;
 		}

 		alt_port->dp_alt.svid =3D USB_TYPEC_DP_SID;
@@ -466,48 +465,42 @@ static int pmic_glink_altmode_probe(struct auxiliary=
_device *adev,

 		alt_port->typec_mux =3D fwnode_typec_mux_get(fwnode);
 		if (IS_ERR(alt_port->typec_mux)) {
-			fwnode_handle_put(fwnode);
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
-					     "failed to acquire mode-switch for port: %d\n",
-					     port);
+			ret =3D dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
+					    "failed to acquire mode-switch for port: %d\n",
+					    port);
+			goto put_fwnode;
 		}

 		ret =3D devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
 					       alt_port->typec_mux);
-		if (ret) {
-			fwnode_handle_put(fwnode);
-			return ret;
-		}
+		if (ret)
+			goto put_fwnode;

 		alt_port->typec_retimer =3D fwnode_typec_retimer_get(fwnode);
 		if (IS_ERR(alt_port->typec_retimer)) {
-			fwnode_handle_put(fwnode);
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_retimer),
-					     "failed to acquire retimer-switch for port: %d\n",
-					     port);
+			ret =3D dev_err_probe(dev, PTR_ERR(alt_port->typec_retimer),
+					    "failed to acquire retimer-switch for port: %d\n",
+					    port);
+			goto put_fwnode;
 		}

 		ret =3D devm_add_action_or_reset(dev, pmic_glink_altmode_put_retimer,
 					       alt_port->typec_retimer);
-		if (ret) {
-			fwnode_handle_put(fwnode);
-			return ret;
-		}
+		if (ret)
+			goto put_fwnode;

 		alt_port->typec_switch =3D fwnode_typec_switch_get(fwnode);
 		if (IS_ERR(alt_port->typec_switch)) {
-			fwnode_handle_put(fwnode);
-			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
-					     "failed to acquire orientation-switch for port: %d\n",
-					     port);
+			ret =3D dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
+					    "failed to acquire orientation-switch for port: %d\n",
+					    port);
+			goto put_fwnode;
 		}

 		ret =3D devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
 					       alt_port->typec_switch);
-		if (ret) {
-			fwnode_handle_put(fwnode);
-			return ret;
-		}
+		if (ret)
+			goto put_fwnode;
 	}

 	for (port =3D 0; port < ARRAY_SIZE(altmode->ports); port++) {
@@ -526,6 +519,10 @@ static int pmic_glink_altmode_probe(struct auxiliary_=
device *adev,
 							  pmic_glink_altmode_pdr_notify,
 							  altmode);
 	return PTR_ERR_OR_ZERO(altmode->client);
+
+put_fwnode:
+	fwnode_handle_put(fwnode);
+	return ret;
 }

 static const struct auxiliary_device_id pmic_glink_altmode_id_table[] =3D=
 {
=2D-
2.43.2


