Return-Path: <linux-kernel+bounces-46411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27362843F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626ACB29DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97378698;
	Wed, 31 Jan 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTcupFQR"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798878686
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703654; cv=none; b=fF0vWsZie/h0hlGPr/UzuW9vehg5sEurhblXcl2n5viV/j/6Px9/G8PiDjYq8OOubd+7/RVbcVTx2YbSWV2n1DrQg1JV/m3fHnbu1/oLgSoiAp2JFO+6fkU7eamak8DQlJti3rO09yg9Ggu1ItK8PLMLws8oWuNmIoNPSpB6uf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703654; c=relaxed/simple;
	bh=0BtYXxoyRbEEo8CC0J9V99c66jdyzmAOjg8hCNOZ7b0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hvERmAltigke3EJx4mIbDysozd5vIexSgvRwlGWtKurAEdQV45Jc7zpzZ1FKizMrJ2bSwJiyYOQ5pjnMosgJvOS0FDqM7cHkKYSJvSVOXWQotB282Sa/fXKZzNsNN4V6C2dI7gOnNtUx5mrJsaFmQoHNlLlGZnYpd1XalM/wpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTcupFQR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fafae5532so12144545e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706703651; x=1707308451; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CR4Ho3L6jue69cceJ1b2x5jJZb5ixIFGR4e9QkosqQA=;
        b=JTcupFQR/G3NtuoyS/vT+jQeQ4XtwtBpU+LV2Da2LRSvVW5DzqePKb2PeEiMSGSrBs
         i0WaRtclgZLzUPJBKVZ2+2NxVgd6zZ/B5B2G8ZUYdQaNvoMIDIpN1x16yxcRiEMDgxu6
         Iwdqx74WFE2fOFBTlNYA4hA+Wkwsvz0nGjikfxyjWtKpNdEtgtxU7DQdPFH5lxmpKc7F
         SchQxoUpINV4CY74zh3NN+pxpEHHq/24Pj3ScIlrJ4ysY4wYKdNVZU3J9rvVYVWPH8lL
         ZXDWKQ3cudchQmlw0glKEBJGGowzP3Sqmrvx4rYpwmCGnIPv9YrHIRMy/ZVl/zNORRQ3
         0+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706703651; x=1707308451;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CR4Ho3L6jue69cceJ1b2x5jJZb5ixIFGR4e9QkosqQA=;
        b=tWVd19RGVg4FZDnM3HYigLXZhhkXPHVkGSF1OubGCRlGrDNa9H0wbnCVw9l06QunGI
         ztU60CMzOhHCKoidXh+q2AjkDMX/iTp5ISEh8IchatHF6hhTZSBr6E4qo3DpLI5V6kCo
         20642Mfccfyjb/mq3hmMSSpjYo0+upg4DnvIjoh0KBhyQoEnrfXchDrs98kMpjIpAcK2
         /Z4jc4vs6yhpcTPq85vU0n+RvVf+J6NSwgB2dJZh1wMjP8ZimurOpzKYzjUuiGUvV2Xi
         lnzEmD3j9wsM0ler1eIIqNDOafUo5NiibWwbWE44IBf0dFvBvEfuMAJEISxZxBuX4Yxl
         p4UA==
X-Gm-Message-State: AOJu0Yz0PFR3inG2Gnve6ZkmRf9pRYajN6uP5puBuGs7jLbl888QJC/h
	I8iyQYmLIXXSnOIakOr8tCc5XxWWmnYOzyFQo7hqCAxjapDoG5su
X-Google-Smtp-Source: AGHT+IHrAFGvgzNAU1x7cZ3VVZ2tm8h0xv0lhf3R+ivG9q/H4NNgiS0W+QqF0r52fYuf/YDbvb9dHQ==
X-Received: by 2002:a05:600c:19c9:b0:40e:a0a3:f358 with SMTP id u9-20020a05600c19c900b0040ea0a3f358mr1077732wmq.22.1706703650656;
        Wed, 31 Jan 2024 04:20:50 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id z12-20020a7bc7cc000000b0040efb503d58sm1460094wmk.28.2024.01.31.04.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:20:50 -0800 (PST)
Message-ID: <dcb1b6dbc2172dd66bfdcc0c8135e0d98f1c22dd.camel@gmail.com>
Subject: Re: [PATCH RESEND RFC] driver: core: don't queue device links
 removal for dt overlays
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: nuno.sa@analog.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki"
	 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Rob Herring
	 <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Date: Wed, 31 Jan 2024 13:24:07 +0100
In-Reply-To: <20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
References: 
	<20240123-fix-device-links-overlays-v1-1-9e4f6acaab6c@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-23 at 16:40 +0100, Nuno Sa via B4 Relay wrote:
> From: Nuno Sa <nuno.sa@analog.com>
>=20
> For device links, releasing the supplier/consumer devices references
> happens asynchronously in device_link_release_fn(). Hence, the possible
> release of an of_node is also asynchronous. If these nodes were added
> through overlays we have a problem because this does not respect the
> devicetree overlays assumptions that when a changeset is
> being removed in __of_changeset_entry_destroy(), it must hold the last
> reference to that node. Due to the async nature of device links that
> cannot be guaranteed.
>=20
> Given the above, in case one of the link consumer/supplier is part of
> an overlay node we call directly device_link_release_fn() instead of
> queueing it. Yes, it might take some significant time for
> device_link_release_fn() to complete because of synchronize_srcu() but
> we would need to, anyways, wait for all OF references to be released if
> we want to respect overlays assumptions.
>=20
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
> This RFC is a follow up of a previous one that I sent to the devicetree
> folks [1]. It got rejected because it was not really fixing the root
> cause of the issue (which I do agree). Please see the link where I
> fully explain what the issue is.
>=20
> I did also some git blaming and did saw that commit
> 80dd33cf72d1 ("drivers: base: Fix device link removal") introduced
> queue_work() as we could be releasing the last device reference and hence
> sleeping which is against SRCU callback requirements. However, that same
> commit is now making use of synchronize_srcu() which may take
> significant time (and I think that's the reason for the work item?).
>=20
> However, given the dt overlays requirements, I'm not seeing any
> reason to not be able to run device_link_release_fn() synchronously if we
> detect an OVERLAY node is being released. I mean, even if we come up
> (and I did some experiments in this regard) with some async mechanism to
> release the OF nodes refcounts, we still need a synchronization point
> somewhere.
>=20
> Anyways, I would like to have some feedback on how acceptable would this
> be or what else could I do so we can have a "clean" dt overlay removal.
>=20
> I'm also including dt folks so they can give some comments on the new
> device_node_overlay_removal() function. My goal is to try to detect when =
an
> overlay is being removed (maybe we could even have an explicit flag for
> it?) and only directly call device_link_release_fn() in that case.
>=20
> [1]:
> https://lore.kernel.org/linux-devicetree/20230511151047.1779841-1-nuno.sa=
@analog.com/
> ---
> =C2=A0drivers/base/core.c | 25 ++++++++++++++++++++++++-
> =C2=A01 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14d46af40f9a..31ea001f6142 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -497,6 +497,18 @@ static struct attribute *devlink_attrs[] =3D {
> =C2=A0};
> =C2=A0ATTRIBUTE_GROUPS(devlink);
> =C2=A0
> +static bool device_node_overlay_removal(struct device *dev)
> +{
> +	if (!dev_of_node(dev))
> +		return false;
> +	if (!of_node_check_flag(dev->of_node, OF_DETACHED))
> +		return false;
> +	if (!of_node_check_flag(dev->of_node, OF_OVERLAY))
> +		return false;
> +
> +	return true;
> +}
> +
> =C2=A0static void device_link_release_fn(struct work_struct *work)
> =C2=A0{
> =C2=A0	struct device_link *link =3D container_of(work, struct device_link=
,
> rm_work);
> @@ -532,8 +544,19 @@ static void devlink_dev_release(struct device *dev)
> =C2=A0	 * synchronization in device_link_release_fn() and if the consumer=
 or
> =C2=A0	 * supplier devices get deleted when it runs, so put it into the
> "long"
> =C2=A0	 * workqueue.
> +	 *
> +	 * However, if any of the supplier, consumer nodes is being removed
> +	 * through overlay removal, the expectation in
> +	 * __of_changeset_entry_destroy() is for the node 'kref' to be 1
> which
> +	 * cannot be guaranteed with the async nature of
> +	 * device_link_release_fn(). Hence, do it synchronously for the
> overlay
> +	 * case.
> =C2=A0	 */
> -	queue_work(system_long_wq, &link->rm_work);
> +	if (device_node_overlay_removal(link->consumer) ||
> +	=C2=A0=C2=A0=C2=A0 device_node_overlay_removal(link->supplier))
> +		device_link_release_fn(&link->rm_work);
> +	else
> +		queue_work(system_long_wq, &link->rm_work);
> =C2=A0}
> =C2=A0
> =C2=A0static struct class devlink_class =3D {
>=20
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240123-fix-device-links-overlays-5422e033a09b
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20

Hi Rafael,

Would be nice to have your feedback on this one or if this is a complete na=
ck...
I think calling device_link_release_fn() synchronously is ok but I might be
completely wrong.

+Cc Saravan as he should also be very familiar with device_links and see if=
 the
above fairly simple solution is sane.

I also don't want to be pushy as I know you guys are all very busy but it's=
 (i
think) the third time I resend the patch :)

- Nuno S=C3=A1

