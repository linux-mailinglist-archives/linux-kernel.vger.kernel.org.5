Return-Path: <linux-kernel+bounces-39209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0582783CCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C8029E316
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F01C1350F2;
	Thu, 25 Jan 2024 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCVPbcj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C1136643;
	Thu, 25 Jan 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211650; cv=none; b=UCId7roQJGtyjdnz2l1Y54QFVu3YeDmMNixCiGyIloGZDcGbzryi5vsR8x2BD+26JdFiXBDWTCWXP3P+PBuTnFwMsuXqx9hKtcf71ilzhCLJUbgbSriQsvUcl5NpIP99eatnZx50nhpa9J2hyWE3chE5wM3MxX+yY1Ftdy33SIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211650; c=relaxed/simple;
	bh=lH13S7WP6c/wzquKhAvxVZUMUVymqFChewATNqH4gz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUo4a/JO/Ob0i0XyKD2diZaiPW1LyO/QIrNx0DgEg9Ufgr73XeNzY9q8jABH9FllsPmiaR3aSbponyQ1glbcmvM3cXDPD+Rzt0auOJuibjZlrnbe99myQOQlsN2IGhv28gy0zjKUADSsby7gmT7zycS7xvfvAIywQH7Y7NJtvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCVPbcj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5153AC43399;
	Thu, 25 Jan 2024 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706211650;
	bh=lH13S7WP6c/wzquKhAvxVZUMUVymqFChewATNqH4gz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jCVPbcj+HlohDL7X0DyOvB81CTt1D7dhiQriNdWzh/tdCRJI61ChWuO3PSKo3GJlg
	 FhZC5yYxMEOrG26mhV33Gom4xNcaTGacTSeluoEl/4vPxRnWSc1qqpUKaqa+oaNWl7
	 PsF+12qiIjf1h6BVpHyNQ/fTg7Fxk04Gl1JDMhm1JL4t4TCXkPMoEaJA2eY6J70/fh
	 KDGDg1mvaoBscQYISeom+8j49vxMqaoauJEI8E2S30YbV5z5CKCAI+C1d2q168rkrF
	 nVNBEQgXaq0zUQcedZQ9iTJnNyWphQd4Etm9jSskVLiN0UzPpQ+sMpHebaKH2ETGpA
	 WRIgc6maMue3A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso60862e87.0;
        Thu, 25 Jan 2024 11:40:50 -0800 (PST)
X-Gm-Message-State: AOJu0Yx10Kawh2hN6LE5K9QxTpCtZnLCSOhXs3i7x7acEuKXRBl+d9CE
	cbvYjnH0sH0F04IlSGmgp69ICWBDafFPEBKVGqYRk/tX5E7zuQwdzhqxxE2TeejV/dAw+UmjnSJ
	vzQsLWcgk1ec0rQxmPIBTeBop2lk=
X-Google-Smtp-Source: AGHT+IEmmy/oYCCQ8m4FZydhGAb8Iou3wY9Znis0Q3YCYCbAA1JDBRcMVIKpfj5rcmRqgLwdKZrN+nUnqPHFsZD40oU=
X-Received: by 2002:a05:6512:6d:b0:50e:ac2a:6b6d with SMTP id
 i13-20020a056512006d00b0050eac2a6b6dmr171299lfo.119.1706211648451; Thu, 25
 Jan 2024 11:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW7KMLHHrcyZhKS_m_fwWSKM66VFXaLj9fmY+ab5Mu3pvA@mail.gmail.com>
 <20240123235803.8298-1-dan@danm.net> <CAPhsuW49L8B9K8QFg68v=zG9ywMehUTD18DaG4PexEt-3mzQqQ@mail.gmail.com>
 <2ef7d741-3df8-402a-967f-53ec77c73e2c@oracle.com>
In-Reply-To: <2ef7d741-3df8-402a-967f-53ec77c73e2c@oracle.com>
From: Song Liu <song@kernel.org>
Date: Thu, 25 Jan 2024 11:40:36 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6nVUCYNtW-2a7q+T5zhyw=NhgcfP7jMeV9e_FJ5TfvXg@mail.gmail.com>
Message-ID: <CAPhsuW6nVUCYNtW-2a7q+T5zhyw=NhgcfP7jMeV9e_FJ5TfvXg@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: junxiao.bi@oracle.com
Cc: Dan Moulding <dan@danm.net>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:44=E2=80=AFAM <junxiao.bi@oracle.com> wrote:
>
> Hi Dan,
>
> Thanks for the report.
>
> Can you define the hung? No hung task or other error from dmesg, any
> process in D status and what is the call trace if there is? From the
> perf result, looks like the raid thread is doing some real job, it may
> be issuing io since ops_run_io() took around 20% cpu, please share
> "iostat -xz 1" while the workload is running, i am wondering is this
> some performance issue with the workload?

I am hoping to get a repro on my side. From the information shared
by Dan, the md thread is busy looping on some stripes. The issue
probably only triggers with raid5 journal.

Thanks,
Song

