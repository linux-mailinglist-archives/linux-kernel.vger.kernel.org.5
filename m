Return-Path: <linux-kernel+bounces-123252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA0890528
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B72E1F25FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5CC130E5A;
	Thu, 28 Mar 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="f6dDQoVp"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE17E788;
	Thu, 28 Mar 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643246; cv=none; b=TRdOkJ91QEGfsPznMepto9e13pslkAiM5jZLJvxhgUI0CjK+PruS0t8EORfCMxYY50sC3f5u5jYnFXrZbHDQySnT49rlNb5mk2AdF89taSAD5rtzCs/5hBA5QrlZCXgO1uwQMQIxUsn2Ihp+XfAYkqnL2gls+QAsiBG6F1fx9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643246; c=relaxed/simple;
	bh=dIb9eE7iYPMGcvU2C0yJgjBaPJT0qXXikLkp/Z4F09M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:Cc; b=klzcwefSGkicP5QPN+K5Z1Sxoa1Kk7FxhSkVotqlkuG65YaraM4QGsehPuv1X3S2ejRC9etzM4Q7ttQx9EYoEfh0K50yZEODGoHKWi1azKdZMqSoMDAEjgN23APYRYXUA/q17KXOP/SsdTBhjDL4pa6KpB1qkDERj33sAbEqaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=f6dDQoVp; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711643225; x=1712943225;
	bh=UIMr0cXzQ7K9MqVml1YbFic1/i1jalZvSB0LSoBSsDQ=;
	h=Mime-Version:From;
	b=f6dDQoVpmL/onp80cBDa4r6ezxFbnUEqH6rIQrDZ7YxoFaSmFHcoPjc1iwm4d70Pt
	 jS+lzJFdJwuybbUfRpSeSuahAsKGXstZb6Aj6AOlAut1kWTLcWsHwuvuPuvg34MnbM
	 5ldTqipkpguHZfzuYXcSBwFr9ky3DGT09dQeULHKGP0nL73N7tGH+iMFKA1ldx570H
	 TPiobmP+202I07GapaeAPvsh9CBDFrwBAlDJJKY/dyKzgwG8wkYhkvfgI0F3/Qc86i
	 88IPUo70ueRVyPpeZh4NOt/gVpDhbnvjsV1iaNnVNbmw/uZggmGl/w7IELrLMVFrG1
	 sMb0u0e7l4ssA==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42SGR3at063608
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 17:27:05 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 17:27:03 +0100
Message-Id: <D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz>
Subject: [REGRESSION] PWM vibrator does not probe with v6.9-rc1
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: <regressions@lists.linux.dev>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>

Uwe,

I am working on bringing the mainline Linux to my old smartphone. Most
of the changes are not yet in-tree.

The phone has a PWM vibrator for which the corresponding input driver
(pwm-vibrator) is used. The driver used for the PWM is pwm-pxa (or
pxa25x-pwm).

The DT nodes look like this

[...]
	pwm: pwm@1ac00 {
		compatible =3D "marvell,pxa250-pwm";
		reg =3D <0x1ac00 0x10>;
		#pwm-cells =3D <1>;
		clocks =3D <&apbc PXA1908_CLK_PWM3>;
	};
[...]
	vibrator {
		compatible =3D "pwm-vibrator";
		pwm-names =3D "enable";
		pwms =3D <&pwm 100000>;
		enable-gpios =3D <&gpio 20 GPIO_ACTIVE_HIGH>;
		pinctrl-names =3D "default";
		pinctrl-0 =3D <&vibrator_pins>;
	};
[...]

The vibrator worked fine with v6.8-rc6 but after I rebased to v6.9-rc1,
it no longer probes printing

	[  +0.000118] pwm-vibrator vibrator: failed to apply initial PWM state: -2=
2

to dmesg.

I have bisected the problem to 40ade0c2e794 ("pwm: Let the of_xlate
callbacks accept references without period").

Looking at the commit and adjacent history, I don't believe this problem
is caused by this still being an out-of-tree DT, nonetheless, if it
proves to be the case, then I apologize for false alarm.

Would you please take a look?

Thank you and kind regards,
K. B.

#regzbot introduced: 40ade0c2e794

