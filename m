Return-Path: <linux-kernel+bounces-84675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0591286A9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CEA1C216E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604992D05E;
	Wed, 28 Feb 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPDTLpAT"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F242D04C;
	Wed, 28 Feb 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109169; cv=none; b=BjMGXRw2YAjCmbm40Mc0IaSd7uA32kHvuB6LYeuR1z+owyTx0OPS/JgSD5V35v02cyOox32OFrYmca26kauH6iLWfmBSygf/lLhFEB5wbuPMmGCagnHoM33TM5+rauy+nGAlnOw9CcOxzdAE2cyJoxIpagnPD+ovqU/yelPNe8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109169; c=relaxed/simple;
	bh=t40K0JM0NMfK3mCMUC77qdJh8lHBWSded2PQLMcMHuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T39lvtBSXvfQ/ywjsOU3BUBsUVkQBSvW8pGgVEYCtIqg9X/qETz2XsooiHc9nQilZYAAP5sYslTGsMvDb+fVdo/y+7jJ1Hw1ftGcQbFudmnBnlNWUt+B1zha+sf3ZWlXPcW7L4bPRXgngL1J+EVa+UD3z38D8cbXlUZVnjBc0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPDTLpAT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4284104a12.1;
        Wed, 28 Feb 2024 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709109167; x=1709713967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t40K0JM0NMfK3mCMUC77qdJh8lHBWSded2PQLMcMHuM=;
        b=bPDTLpAT020g7yTaG9s9Dg5fvjrKx4wikeZJpv+bqHd0xAYQn/zDrG1BhttuJrKgVn
         BRbLmFTzsVmcWnqrMNVSvOmW0IYk3EgWkGSvzQDgUnM1ucTKtYfblJhOgfvw4Dxk1nPV
         h3dveXFWmESQ1te1DbRn94501+g735ohKL12hnWhzWXcxXidqSmqKXglwovFjuIU23L/
         ojrTLtjlcGJTtEylQ9DXIJDkB5S7+alsj0ur2To6ifkNGcmoZzGstbfxEzbyhFvfYPVN
         jE4ogmXaI4K5WzOBoVSak8WIrysUAvVbLAhplUK8lBFFEuUGjOlQDcg9/j6wCEOxxSkE
         44xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109167; x=1709713967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t40K0JM0NMfK3mCMUC77qdJh8lHBWSded2PQLMcMHuM=;
        b=CrnSSpA1MmIyHpb8xQiYuhC+jttMmvCok1/T5fOGdeXYTukMyaSeLxpaaB/4OyJ9Ob
         HN6BQn+aOSVTIVuOJr3hieI4DoxNQXddEe0ve8rkUYSs7nPyTCIKu+Epzs251ev775l2
         FT4PAdYn3OMfKdz7wPluB2wdS36oMW0PHmhR2/0T/TiSYHJuqFTwODkCyorD1PikzWb7
         nb0VYiOlAy56PioT6m01sFKMZvtjhW3b8ISQsyUQHpQKDFucxgK0bnVKdBfUJyf3Ijb8
         c1dNktGS8ks5AEV8UxLBFxPXOaggnUhtHthtl9Ql4atpcC81C+Drji1XyNC32J0XHZ6Z
         fFYw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ITVEfXj0EJRUU55yWNANpfu9J7i9Zp9J4G5RBI9I1Psz/Dcmq0Wbp21ns5i1hRfAnnCTw8TfKD9uoHCFdFf5hptWdd+8HO5UrKvlcKPmb9XelPAHWnHa2WjUo9z6G5LgtBph
X-Gm-Message-State: AOJu0YxR+SVuJphv/oooYDRUl1WmjB9goUUD21sslOcPF2ScrScgJS7s
	Nj3uwndeyZI10RirublsIq6ODcg1hWJvqSLrmagzQM5OiJlGfdLc
X-Google-Smtp-Source: AGHT+IEPBy5Yel+v4FYYx1dJ/kW3sj9XgdN6GjR1Lqmv35o9Q62to13V/d1NNwcnNw4qpmaVH/AN5A==
X-Received: by 2002:a17:90a:88c:b0:299:3f10:20ba with SMTP id v12-20020a17090a088c00b002993f1020bamr10292017pjc.27.1709109167564;
        Wed, 28 Feb 2024 00:32:47 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id sy12-20020a17090b2d0c00b00296f4fc7e60sm962560pjb.12.2024.02.28.00.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:32:47 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D8B75187DBEB7; Wed, 28 Feb 2024 15:32:41 +0700 (WIB)
Date: Wed, 28 Feb 2024 15:32:41 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Abdul Anshad Azeez <abdul-anshad.azeez@broadcom.com>,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>
Cc: Boon Ang <boon.ang@broadcom.com>,
	John Savanyo <john.savanyo@broadcom.com>,
	Peter Jonasson <peter.jonasson@broadcom.com>,
	Rajender M <rajender.m@broadcom.com>
Subject: Re: Network performance regression in Linux kernel 6.6 for small
 socket size test cases
Message-ID: <Zd7vqSnT6ocYLuZ4@archie.me>
References: <CALkn8kLOozs5UO52SQa9PR-CiKx_mqW8VF9US94qN+ixyqnkdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aJ0FkAcvBcopWHIX"
Content-Disposition: inline
In-Reply-To: <CALkn8kLOozs5UO52SQa9PR-CiKx_mqW8VF9US94qN+ixyqnkdQ@mail.gmail.com>


--aJ0FkAcvBcopWHIX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also Cc: regressions ML]

On Wed, Feb 28, 2024 at 12:13:27PM +0530, Abdul Anshad Azeez wrote:
> During performance regression workload execution of the Linux
> kernel we observed up to 30% performance decrease in a specific networking
> workload on the 6.6 kernel compared to 6.5 (details below). The regressio=
n is
> reproducible in both Linux VMs running on ESXi and bare metal Linux.
>=20
> Workload details:
>=20
> Benchmark - Netperf TCP_STREAM
> Socket buffer size - 8K
> Message size - 256B
> MTU - 1500B
> Socket option - TCP_NODELAY
> # of STREAMs - 32
> Direction - Uni-Directional Receive
> Duration - 60 Seconds
> NIC - Mellanox Technologies ConnectX-6 Dx EN 100G
> Server Config - Intel(R) Xeon(R) Gold 6348 CPU @ 2.60GHz & 512G Memory
>=20
> Bisect between 6.5 and 6.6 kernel concluded that this regression originat=
ed
> from the below commit:
>=20
> commit - dfa2f0483360d4d6f2324405464c9f281156bd87 (tcp: get rid of
> sysctl_tcp_adv_win_scale)
> Author - Eric Dumazet <edumazet@google.com>
> Link -
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D
> dfa2f0483360d4d6f2324405464c9f281156bd87
>=20
> Performance data for (Linux VM on ESXi):
> Test case - TCP_STREAM_RECV Throughput in Gbps
> (for different socket buffer sizes and with constant message size - 256B):
>=20
> Socket buffer size - [LK6.5 vs LK6.6]
> 8K - [8.4 vs 5.9 Gbps]
> 16K - [13.4 vs 10.6 Gbps]
> 32K - [19.1 vs 16.3 Gbps]
> 64K - [19.6 vs 19.7 Gbps]
> Autotune - [19.7 vs 19.6 Gbps]
>=20
> >From the above performance data, we can infer that:
> * Regression is specific to lower fixed socket buffer sizes (8K, 16K & 32=
K).
> * Increasing the socket buffer size gradually decreases the throughput im=
pact.
> * Performance is equal for higher fixed socket size (64K) and Autotune so=
cket
> tests.
>=20
> We would like to know if there are any opportunities for optimization in
> the test cases with small socket sizes.
>=20

Can you verify the regression on current mainline (v6.8-rc6)?

--=20
An old man doll... just what I always wanted! - Clara

--aJ0FkAcvBcopWHIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZd7vpAAKCRD2uYlJVVFO
o3FWAQDe+PbGL4LW/N1x23XLUSDEsqAGX9WqhwvPNQEir1nE3gEAqt155Cln5op5
oMAlTfo6KFQ5Sl5qdUv70rbcuu4T+gs=
=88Qq
-----END PGP SIGNATURE-----

--aJ0FkAcvBcopWHIX--

