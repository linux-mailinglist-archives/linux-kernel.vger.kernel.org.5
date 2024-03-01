Return-Path: <linux-kernel+bounces-88021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A686DC48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C458528B43E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862469971;
	Fri,  1 Mar 2024 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vEWh/wuj"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE302405DB;
	Fri,  1 Mar 2024 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279212; cv=none; b=DX9q3YT17fIBif5ZvPGfU6C+FK0X3M5TOESgT15z2b61jR07dRWyYekvoI+w+istQe3hfl8J/uCrGv3NvhPcP2AdEPCqq149n0XgIlXqpN6Jh6AQ6f8/OcOMfEBeT0PR8E/+n+k3AdgOyCTtDSUk3EcnjVGuRaM+tiLiyAZcmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279212; c=relaxed/simple;
	bh=PtVj2Cs/5utkaUVwbD5AXLYA8GHmi80b51Oqj9vJ8HQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OVdWBBVUFc4Z3aMPvPJnojWueH3JtSeowaG37lMqRXEsgqL+LlZhtHczykNMNkymyo+znHieSnVpNHEsWgCiOajnSikGLmG4vu8mAx6ThErSSm4KT6UN25jIluDzuaDRQUx2uMhYsJIO0CLprX6FrOIus6xDfhT+paolF4/Wf0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vEWh/wuj; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709279197; x=1709883997; i=markus.elfring@web.de;
	bh=PtVj2Cs/5utkaUVwbD5AXLYA8GHmi80b51Oqj9vJ8HQ=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=vEWh/wujuPkr5ZgUKGrC7CR17ajTtwB8K0+7BUgACfosZ+YkVCxOkokrpBZ0MHPL
	 yKIjqDGCfxtom0sTR+kmTUpuj/Ok4KAHTlO0RzySVvafbhY11Ga9PMd5zSS4PyfQk
	 VAX3ElI3F02jdmh7X9DeJJqt3yfJlOnzxr462cjXEc2apqKpTvBXySiaALaGBBoMX
	 I6Hs/BbvcvpBhoCBMaHFPQsQzG05yzM24gN8r+XBlIYbCaArZsEpXpM31FFpOEHOW
	 7nq8J8PkDaZMkyJ5Fs9eQfpsP6ak3+rXIOvj5AjCv9Rt1xeAiLgmrhFKbnRcpHObg
	 1uWF8XPffY4vRwqsmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1rZx3v2OaY-00Baxt; Fri, 01
 Mar 2024 08:46:37 +0100
Message-ID: <79fa4854-976d-4aad-86ac-c156b0c4937e@web.de>
Date: Fri, 1 Mar 2024 08:46:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] media: i2c: ds90ub960: Delete duplicate source code in
 ub960_parse_dt_rxports()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NG6uo48tDikPs/0i4tEmGu816A1pQ83tsl2OXdg3u6hJ5bwtoyO
 BjRU6fcWGkrgTk6joa1FlnF7RBUozfSJH9fqxJz0A/9TmzxZpXJTDatt1LM6B3NsqdN5T26
 H853kokKn63cWdDZhBzT1ojYkPPy/rDan4daCVEou18V1+O5cXYY3P5ds0+ijVcTx9+xs+7
 SXRSO+1JjmgDt/TNkOLDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z/ukpIoRDls=;0SinomGpMNGuyZ7CuXAkKrUBS69
 o5VCs//WXLxsJQAdvYJT6ILPRcp+zspbC2T8zbwkUYBbMK7VQH3YrN1nXJQ7lz+VP7qB5HCQ7
 n0/2lrwFfPwLCLSAx2nobiKHpwod+w+dPsLaqJzvpckXRLU5x/WZHQw8HfqkC//80zFd4fxv4
 XMlFzDr5n5CC5os48AgQIe2jg3wPcH7gho1UcMg5RHfDD4Z/MvyJFkNbjYDXbbXsrBUH1jkiH
 Gvyptdpm1ftYOsc7TuH29vWpSWTqFGQ4n3NjkcP4U/OvWq3nDC1bdDLPUxj+yHN4uEYniMw36
 mCf0odVkbJ7ubKuBmdM5ZymzMNYfVlmvEhsYDOnLRL8Z0LYWwUX1Imd82WWD/fTVVKBsAtGQ+
 rT+tnd3um6Eag2RfK72cIPA4hzeD+14/ErRAMKAEgkJ9DaoHdCN664tBqak+n880rt8zZa4Xj
 X1HJb56WmFXbVpuBjcX+Fv/NfPHefUHFK4wyeYYwCO01I+8qYdOBKHpo8VWzAxpJuzqTBdtJD
 8ZMn7OihOAHohXt1H9rzkeX0ezhzA50MA85RQSCycfQWd670621IiHhqprNTZy3VheNbNId6K
 5d5Kzl9TpRWKAFFUE1bADesH6ffb5BGJCL4QUeltuGPotcTwUJN+8ubtHccdSHRegVDgsLMjG
 s7I8lfaJh900ZealoffrLoTp7e/d86mNk1KU+MSaeaDgpEy+lZKUaXeZrTd4zR5ztMeBQYdYA
 RcV5FisSS9OjRwARJpVix0Gw3k6Stevs/69UqHG9kOqsiTpD+3yuopk1UjOG46JfjaFDJvehl
 xxs6FmrjLYbbqpC7/0WYXaGaboDF5hmko5g4g/ePy0tCw=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 1 Mar 2024 08:23:24 +0100

Avoid the specification of a duplicate fwnode_handle_put() call
in this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/i2c/ds90ub960.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
index ffe5f25f8647..eb708ed7b56e 100644
=2D-- a/drivers/media/i2c/ds90ub960.c
+++ b/drivers/media/i2c/ds90ub960.c
@@ -3486,10 +3486,7 @@ static int ub960_parse_dt_rxports(struct ub960_data=
 *priv)
 		}
 	}

-	fwnode_handle_put(links_fwnode);
-
-	return 0;
-
+	ret =3D 0;
 err_put_links:
 	fwnode_handle_put(links_fwnode);

=2D-
2.44.0


