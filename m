Return-Path: <linux-kernel+bounces-49573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F0846BED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599D41C26F14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC947AE60;
	Fri,  2 Feb 2024 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKBsEnsx"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4177BAFA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865918; cv=none; b=G0cwC8wZNClKX+cb5oUvIDdWNwFioBQ4738K32T2apmVy4RMnRMBOut85xxW8FwHmmHOz8JcyBf3kiBPay3UQE3LXRWey9q/7uYoAZrfHeEHuxQST6Zc0Qm1qFfpz/bopfqJ1Q6FlqVccANjZt41/2mK+WqB5Jcm7PP2/nD9smk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865918; c=relaxed/simple;
	bh=fnmqYvA56Zz8Eso8lomhs4kIgscSdpmYnGPeuXogSRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWlE0tm11W+uYyHDCVAiaRzJpIvZRdIfIsslsnL1A26pCWKLsL+HW6o6gQAkgYV3LiIywl3p2VEspD1zBVbL4ksK8KvKjnBFMFoJcHlnGO1OTw6lo2DEoJFlLMOc7m6VusDz1k7wXTOy16tMRdx0EM2E2UANqjHZJ1Gxwkkxlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKBsEnsx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68c4673eff5so10529086d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706865915; x=1707470715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnmqYvA56Zz8Eso8lomhs4kIgscSdpmYnGPeuXogSRw=;
        b=OKBsEnsxtlTrPYO3T3WTbKtHgEpauFxjHECY6LPPkhcrkFpzYMr9e6ILX07SLQ7LVp
         Eea0PquwTRlHKSQKAMVdLyCsUxw4aM16EKl39+T7PdGtgKkHF2NKoWldCpeZ3/I0XaG4
         7c74gOjlykuHNEL+mhQMYFGrjjCMyAjhRKn12mwEFKv4Odw6zaFSHE8sgcGQD3BUJ9eV
         ZMcgUWK6TQOOgp2z5e1flS566jN8wruefxC1Rtnd1ezeZFaBAruna29dvrEX4mgQKcGf
         x9g4kX5v4jDZjId5ZOci0QByrk9QgC6A26Hc1795JzIcbn3bskuLPO5kXaQH7riDL4hH
         +0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865915; x=1707470715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnmqYvA56Zz8Eso8lomhs4kIgscSdpmYnGPeuXogSRw=;
        b=fReib81J2AloZWTvqNqZQiFLLlKCKURiU9Sy2ONWmNXJdvl20sck+amqSqeke+TClL
         zpqaOfeIcT4nAWta9leWsJgZGFUqXTGckN9D66ZiyO5xlEoN201BJoPXz9Kx9KiZqL+9
         CO0NLNLe2GqEDGvt70JKzbEOH7IoInckJhzRmsAYEyiesDT8GWZGhF3IAyduGE+Q1Uhn
         Ad0NGMNEJC3whCUOHKPct1Tt+BkwxJVxmYfXYvg/Zdb5pIEriCC/y4CeKXtiyewiOKON
         oEnjvPMbPusve0m6aYWYCNWyzgGgjppa/0RynXUSW+JtwxxSvkkU65mnlOgjth5cof+5
         W7Tw==
X-Gm-Message-State: AOJu0YwX1bbhAgX89IcxZitFu7vQpTV6lVALvbEm3YVjkg+7xLHRP74q
	oNAB1LA9FUZri2+dW6Dql/J5jYs4SHnXcLgT3fx5T6R4nWQU6W0PgeI8NLbIkT87nMMvZh02DfK
	sXNmeSV6U8rovU1moyFG3M2SuaW8=
X-Google-Smtp-Source: AGHT+IE9cNG3sz11N0QRuC78t6vGU21ikbAl+arTMtQUFcQAt3aBQPWr0ea3DbEbozwD/ORqzuNnt2sz1xBBd5dGRzM=
X-Received: by 2002:a05:6214:cce:b0:685:2233:678d with SMTP id
 14-20020a0562140cce00b006852233678dmr1730712qvx.27.1706865915509; Fri, 02 Feb
 2024 01:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131035535.22258-1-liangchen.linux@gmail.com> <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
In-Reply-To: <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Fri, 2 Feb 2024 17:25:02 +0800
Message-ID: <CAKhg4tL3E_AfsEOyzUr13zcbjzzUY1v5VXdAGMLDYdy5om35NQ@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: Support RX hash XDP hint
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:37=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Jan 31, 2024 at 11:55=E2=80=AFAM Liang Chen <liangchen.linux@gmai=
l.com> wrote:
> >
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing
> > XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > 1.
> > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@dayni=
x.com/#r
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks

I've just realized that I forgot to include netdev@vger.kernel.org in
the cc list. Would it be advisable for me to resend the patch with
netdev@vger.kernel.org in the cc list to ensure it receives the
necessary attention for potential merging? Thanks!

Thanks,
Liang
>

