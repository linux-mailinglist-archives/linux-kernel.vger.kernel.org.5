Return-Path: <linux-kernel+bounces-64822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE2854340
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495F228E03D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1464C12E44;
	Wed, 14 Feb 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VKujJ4Vy"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BF111BE;
	Wed, 14 Feb 2024 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894295; cv=none; b=LBOZHCMaR641gTO9Veg8MjPvj4+kePgqP5uInBQUZyKhmKFG+kCXMq1E4S/jVQuGsBWtgb1mJu633YOP7BZE8nAU031P//lZtjG7m5aqVTKcaBhtKuytu5pfDCCicTHSWefHt3ZTRAj2m78obKN/0pjgZRtQ2LFwXju8soyj3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894295; c=relaxed/simple;
	bh=qHfzr9Z6AbrLnleJ2vRO1YVBS5jWB6XYcpAOq7kcFsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6iCeoJnibiqu0i7nHXcSS8p4R/Aw+bV+ZEKiaxfcy4WllgAe7eHv8iakmOTq7lzohyFjHIuBXgY2erxYAqF6Zi+vhlE3LwtsvYqqZUh7a4OK9y9xCR2YyNmSFFXFbprpR/SyhxZIXy/5+aadUdolHeosK6uUK4ydrXfk1aVjYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VKujJ4Vy; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707894282; x=1708499082; i=w_armin@gmx.de;
	bh=qHfzr9Z6AbrLnleJ2vRO1YVBS5jWB6XYcpAOq7kcFsM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=VKujJ4VydpfQlZJyHHf0w5Ig9CSIgulNK1w/eSsDseTXAI1rmDcXim3TDHHUNzP1
	 quIe6g7hlGlskRtSGev5CbJ0munBdymTMAl1QBmop+o9x8+m1vsYOCyEmbYltpf0m
	 rT9ZoR15nYdqqzrNi3XvBpujnE7PvausvV8HRQ1priDiuZz/pdIyzl/nqGe2ro+lA
	 v1jUw0ruKmwVnZyFTevw9nE8DNdX0hnIrsJiQPA/AT1PnEs2IMOyKVu224FWMry3n
	 R0sJ3HTKwfAn7OxM5e/RWMMcFEqpx7c9d3mobPBg3lvi39rNFZk17EWyUQuZ47al8
	 /wilx0aqBdwW+MT5Iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MIdif-1rmVGp3JX3-00EgDZ; Wed, 14 Feb 2024 08:04:42 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] platform/x86: wmi: Update documentation regarding _WED
Date: Wed, 14 Feb 2024 08:04:32 +0100
Message-Id: <20240214070433.2677-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214070433.2677-1-W_Armin@gmx.de>
References: <20240214070433.2677-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dbO3uuwlKIrxeUIUm3YJzFs4CKaDxi5uNObhcAbIaZAAhlvg2+e
 K49uGcVWqc+0jsJ21zYCSuD1gvfnGOaz/lavIp5EJULuqlPOczxezNcmqmORkKPHcR4ilqf
 DYgO6ZWELDGwQmt2ecVzc3AnhsU3gW9z/YcaT61sf0G+XTa0JWoUK17BEjNx6ig0bNxUiXd
 ofKrinCBS1ZgYahqKjrfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r5GjNjsGBWg=;fOr3OJzvZTvySH0j/QmwI8IVq5r
 gNFXAX765DlnQm182+sLNzCRCTyorUNwUFnogA2J9gkmGwO7lr5cKv9eoRX86Pt+5HeTPzHSI
 17dIyKC7r+PtRXFwYN/GZ+77CuJ0QLm5DiUQbcS0bjiSG++4UY0Ie69kISTSNFAl7ZV3clQ/U
 mLe7g9jTkNqjU7lBFtwtmt7121HXXZq/K90LteNrbE2/uF2E6NuemcVRBmEudfkNrIOPWBlCc
 jcTV4LpIfCoIV6d1vf1sXKOLf57Kn7wsuiN1wu58TJN7JhdZ0WEMClAvOuerbdLO4NSoLoQBA
 NPOldYZwuSuucp6bbH/WR7tjWOsidbbdSomWqkqo5yaxDwTtOYMDc2sBUtnb59E9bO77oltdG
 Vv16sJZ0oN4F9J1j8p+Q5YRgSelH7DJAhv5YBWbYd6FDBl1Syi9uBGdviqLXue8pxtFZyFmeB
 2l/hWCpCtJd5F9tlxntRq8sTpv/V6eY9+v6mwG4UYwZcJ5oryY0ONgEQtNrN6CGj01UVFFt6t
 F/fH2K3SL6m5YQUUBoTPdztzR8qbaxy4fZRwRf3TgczpwLoTCNZSY10te09k0OWEJToH8O1D+
 5ivOMiFCUaMiocgXUwMw6UtF46rZIH10IgsDCcg6QW8gVHc4AL8PdTb4St1iwJ41eDJFzHwA6
 2W+RfsetBm2Vl1dgM/e+Htl6NAOouJv3HV20V48gGKiVuJBUh2MPGUHqmrI/UalA8avzdObLK
 yfBCdmOVNaWvu/CShBz/OM2KLDsgFjsoy/OI0tFeDAoVEFm0RfQDM1O7QgMw/2YtM1Zi2L5lv
 SVCjuNnFEzhOuKzMqVLksEQSnjDBXVJVJiHUuIZS9Ig/c=

Update the WMI ACPI interface documentation to include the fact
that _WED should be evaluated every time an ACPI notification
is received.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/acpi-interface.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/wmi/acpi-interface.rst b/Documentation/wmi/acpi=
-interface.rst
index d31af0ed9c08..06fb7fcf4413 100644
=2D-- a/Documentation/wmi/acpi-interface.rst
+++ b/Documentation/wmi/acpi-interface.rst
@@ -93,4 +93,7 @@ _WED ACPI method
 ----------------

 Used to retrieve additional WMI event data, its single parameter is a int=
eger
-holding the notification ID of the event.
+holding the notification ID of the event. This method should be evaluated=
 every
+time an ACPI notification is received, since some ACPI implementations us=
e a
+queue to store WMI event data items. This queue will overflow after a cou=
ple
+of WMI events are received without retrieving the associated WMI event da=
ta.
=2D-
2.39.2


