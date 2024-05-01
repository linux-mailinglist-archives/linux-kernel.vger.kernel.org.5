Return-Path: <linux-kernel+bounces-165788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0858B919E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9EB1C21B60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59986168AEE;
	Wed,  1 May 2024 22:24:02 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C0D52F;
	Wed,  1 May 2024 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714602241; cv=none; b=gg+tCv0yY1MFJzE6wtgBRrXxVHPVaGBCj/AjcRSxOF0qSIHdJBFtwTGH3x9PoZ84bXqO5ehW6tr5TJgFi4S0kOKoxiR6NGhrdmMCqqrTUXSV86T+EFXMf2K31aQR9ZyBnUzj884dvm6t916jwcF68TNznRg06K+XMBAayvUHZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714602241; c=relaxed/simple;
	bh=ADuypZQLrp42+wzz6dAjns3zYS9BMzA54Y1ziYzZThI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIvbz4ZR+UcoW9RtXPY9WoRaCWDEG9Qu5IWnJkbMiE77mWNu02WDxS00avX7V7FeVK0ddSvh8DYv/HIYz/przAZzNgThwi9I55+BD3fFWHth3aFrSfUpaQ5VQ0P2ygr4o5EjW6+S7ZKgV3xycXTINt6zcKNaLSukzwq0166VltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51967f75729so8770062e87.0;
        Wed, 01 May 2024 15:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714602238; x=1715207038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3qrt1xRo5QCY5suOVWHp3CVjoIjT79/EgSVanPYZqA=;
        b=dYcGljbhfdLuX6dO9hjbgJzg1rZxO9quEq0zdSlLK5ii4AkuZh8VxX4tZXc8lLeuOF
         MdvTlNwVNaU0aymU+3AkOiFuPeksDygeZbM0R4YqfXRpNSdMO5B15wmac6azIRSccRJ3
         y+GFwjQxRmKCSC73klhmdMnWC4ROIJGYUxtuzr95bjjE9QlzlGrd5LwTmjuDcrZ9VHWr
         jckJYKfizfvx2HNLxcl6wMstiK2XHhmjj7PLYFlRNWJydacJpuurL/SZB2ONXyH1XZle
         4XK7uqD4hgjQmgoQwYLjujeKlOzCwR3vQGTZ7LaHcBwKCYV8jWSz/JfDGtQdcntFIeMF
         EetQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy9NP2KBnflRHIAqO1aiL7oWEqK0l5q+UbCiLvEAFsSgHhmT/WPBHIpV83ligzlHjERHCV1gGwHIWKYgYWoZ+Ol29Bmkb1W7qvEjhSmbTz6qOkSfiTtVAuwhgbx3jnjFKkZtWsvkjemyZPkKsW
X-Gm-Message-State: AOJu0YxaABtGnj6Uz1gsWw0s4uZb9TlbTsSKwZiBIlvpg7vPfHXluA+U
	ov8BTLcKT1phjal88jtSe38Da/0dcyiBkd2DG71HNYzjbBu4N8uHMhboT/oJsBE=
X-Google-Smtp-Source: AGHT+IFlCHAjHrJeGruvmMrNXMmEgwG6wQut/ZBB6xteIYiFm12u38mMwzCh41+6l4tjeIvC2F7cHA==
X-Received: by 2002:a05:6512:3b8a:b0:51f:5c3:2d6e with SMTP id g10-20020a0565123b8a00b0051f05c32d6emr464517lfv.17.1714602237131;
        Wed, 01 May 2024 15:23:57 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651239c800b00517746176ebsm4990611lfu.49.2024.05.01.15.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 15:23:56 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518931f8d23so7367866e87.3;
        Wed, 01 May 2024 15:23:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYQnk0GxK7SvpyIHb5CDUrR3VzpWDV4JgKyLTFU3NN6IZybrIdsHCFZcbHnbm3woi0iCJQ7dk6FxeKGSPSh0dG182bZ8yDZU53n3FiT1RZtBoKipljqYVFJwmJ9BzSKl/paiJ5htNIY41SEuuG
X-Received: by 2002:ac2:44c2:0:b0:51b:3ffa:f22d with SMTP id
 d2-20020ac244c2000000b0051b3ffaf22dmr2147374lfm.18.1714602236670; Wed, 01 May
 2024 15:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428054307.1178347-1-iam@sung-woo.kim> <CABBYNZKDouOrxG1XcSq2me0WW3A3yAbfdtonw2XJ54VZ8+Nbfg@mail.gmail.com>
In-Reply-To: <CABBYNZKDouOrxG1XcSq2me0WW3A3yAbfdtonw2XJ54VZ8+Nbfg@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 1 May 2024 18:23:43 -0400
X-Gmail-Original-Message-ID: <CAJNyHpKzhFBJ3N0eF1x0icd7O1VkWbTA9k0Gkm8aCMonsagYwg@mail.gmail.com>
Message-ID: <CAJNyHpKzhFBJ3N0eF1x0icd7O1VkWbTA9k0Gkm8aCMonsagYwg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Luiz,

On Mon, Apr 29, 2024 at 11:15=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sungwoo,
>
> On Sun, Apr 28, 2024 at 1:43=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wr=
ote:
> >
> > Hello, could you review this bug and its patch?
> >
> > l2cap_le_flowctl_init() can cause both div-by-zero and an integer overf=
low.
> >
> > l2cap_le_flowctl_init()
> >   chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE=
);
> >   chan->rx_credits =3D (chan->imtu / chan->mps) + 1;  <- div-by-zero
> >
> > Here, mtu could be less than or equal to L2CAP_HDR_SIZE (4). If mtu is =
4, it
> > causes div-by-zero. If mtu is less than 4, it causes an integer overflo=
w.
>
> That is because it is not valid to have hdev->le_mtu < 0x001b (the
> range is 0x001b to 0xffff), so we should really look into checking
> that conn->mtu is actually valid.
>
> > How mtu could have such low value:
> >
> > hci_cc_le_read_buffer_size()
> >   hdev->le_mtu =3D __le16_to_cpu(rp->le_mtu);
> >
> > l2cap_conn_add()
> >   conn->mtu =3D hcon->hdev->le_mtu;
>
> Yeah this assignment is incorrect and in fact we don't do that if
> le_mtu is zero so we probably should do some checks e.g. le_mtu >
> 0x001a, or perhaps we need to move the MTU directly to hci_conn so it
> can check there are enough buffers to serve the link so we stop the
> connection procedure earlier.

Let's say we moved MTU directly to hci_conn and already checked enough
buffers at the creation of hcon.
Then, what should happen if hdev->le_mtu is updated? (by a new
le_read_buffer_size cmd)
Should hcon->mtu be synced with hdev->le_mtu? Or hcon->mtu can keep
its old value?

Best,
Sungwoo.

