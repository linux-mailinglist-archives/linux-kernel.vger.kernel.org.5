Return-Path: <linux-kernel+bounces-137702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C0F89E62C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8451F21168
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1928158DC4;
	Tue,  9 Apr 2024 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk6wmbLj"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAE2770C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705866; cv=none; b=P8IO3Og4gDgzgw6mIn8Be4H7V/bD8F8denq1GF2D4kdQBwYkJREcA5+LfSlhyWY28T3cOAq+AL8+dF8KteRlPYfZ4mP2aagdVQfbADLDymjku/5qq3wNo6oQb1qzKWJdhtyWUQsVJEGM0kIV07APOAfpRqntxaunIHfjJNxh7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705866; c=relaxed/simple;
	bh=OaIkIC2QzWrtTu86iJit4FzUNOJO8i9O3Jgp5XBIl0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+7U/5+Q6q7eWvTFJtts0b1Y/IstNKvV+Uw75ShKor7KDEU62pS9HiiNGGVNF2F4BQWatYpGREiA7PrPgiDAPbBkUm9+HEufQ5k3DNnHg3I1oEiVHP+s459EL5e9xF5UVsadQFaUnxyduaWxn6G3JSpbMkn46BOlN/SKDexoXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rk6wmbLj; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dad331b828so1005674e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712705863; x=1713310663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej7IAhzJEokhzRF324REk8GQfnDQfJi0Vj6poCRFTtM=;
        b=Rk6wmbLjgTzHQ0NVvIzBNKV9UONk5BYA4BuWNYzKoIr9qQ0OzICfsvCXqVw/tUajG7
         01R1oFoySemTP61YX4H133QiIsg9Cj7G3J77YLOn3z8MUlvCp8M3SHZffMJI52i0JCb0
         eTk7maPpL2Q1TWzcO+yZS1830TteGOyGH7X2XQjdl0Mkj0XeJyOaTiprjRps1rhzpElh
         k7NvS3E++y5e4coGtA2u+9iYHF6YbS45+OsirdB3jLy0swqAMY/Tv5aEfdA0thUsqv1V
         Gnx38HT378wPKDTaSwmzfj1I4WU9+Ptlk5e4r6ScrdVoopiCtPDZ6w5rzXEFEsydYIjq
         S9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712705863; x=1713310663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej7IAhzJEokhzRF324REk8GQfnDQfJi0Vj6poCRFTtM=;
        b=Dis1omcFpN3RFVg9Rt7s13GNTMNOl68o+nBDPT0/toDkJzHW3iI6c+MQbIIQUI/+VS
         4Qjho038ohbYoMi8RKX6YWSKKp4K1tZg5Iq3e0H2LCy+fn4r3dVH2B14GWKg75F2fEBi
         A5ByG5v0LM3vgg1MxobsdarpAnUXV0ttIB3xR+hBGZJd/vuOgDhYbJW51AV4uf/do1wE
         dquewAiyWGFUNARkfzXSNhmls/O0tG3W1A/MevzYMeNkylvx8wTti8BiPztZm/QTAPrq
         hA0JXLADVb5TSTB/oKanRm0MAPyzQ77xxuP027s8OuSUvUOItqjJeM6hYaBbkXEpJ7NK
         Tf7g==
X-Gm-Message-State: AOJu0YxqlHomiMdQi8XWcCusRtqC8y3xVB5Bu0Go6JMGHtK8Ph+a9P0F
	6fpG0/50Bt8a03or7kQEDyRRuMUIdtILITWpsnX06zuVmV5/co+oBgXYquHb56inCyexgzsK5Ym
	NXjYipO5OK3suE4GxRvjNAKJTPeIYJV927Xg=
X-Google-Smtp-Source: AGHT+IE4uEffG0FRzOKJQoQatN7+eWmWAIWgP57PN5fzyXLwJZNfS82Oj6xv1jA1G5sXcA/Re66rtLrBGRvUKkKDrKw=
X-Received: by 2002:a05:6122:41e:b0:4c8:8d45:5325 with SMTP id
 e30-20020a056122041e00b004c88d455325mr1205875vkd.7.1712705863584; Tue, 09 Apr
 2024 16:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404195254.556896-1-jaegeuk@kernel.org> <ZhVqwwCesxWOfbOA@google.com>
In-Reply-To: <ZhVqwwCesxWOfbOA@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 9 Apr 2024 16:37:32 -0700
Message-ID: <CACOAw_xrXi_adcBHqBPURv=SP98S92qYyF1o5xtsOJ9yLfT56g@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't set RO when shutting down f2fs
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	=?UTF-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:21=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wro=
te:
>
> Shutdown does not check the error of thaw_super due to readonly, which
> causes a deadlock like below.
>
> f2fs_ioc_shutdown(F2FS_GOING_DOWN_FULLSYNC)        issue_discard_thread
>  - bdev_freeze
>   - freeze_super
>  - f2fs_stop_checkpoint()
>   - f2fs_handle_critical_error                     - sb_start_write
>     - set RO                                         - waiting
>  - bdev_thaw
>   - thaw_super_locked
>     - return -EINVAL, if sb_rdonly()
>  - f2fs_stop_discard_thread
>   -> wait for kthread_stop(discard_thread);
>
> Reported-by: "Light Hsieh (=E8=AC=9D=E6=98=8E=E7=87=88)" <Light.Hsieh@med=
iatek.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>
>  Change log from v1:
>   - use better variable
>   - fix typo
>
>  fs/f2fs/super.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 8ac4734c2df6..df32573d1f62 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4159,9 +4159,15 @@ void f2fs_handle_critical_error(struct f2fs_sb_inf=
o *sbi, unsigned char reason,
>         if (shutdown)
>                 set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>
> -       /* continue filesystem operators if errors=3Dcontinue */
> -       if (continue_fs || f2fs_readonly(sb))
> +       /*
> +        * Continue filesystem operators if errors=3Dcontinue. Should not=
 set
> +        * RO by shutdown, since RO bypasses thaw_super which can hang th=
e
> +        * system.
> +        */
> +       if (continue_fs || f2fs_readonly(sb) || shutdown) {
> +               f2fs_warn(sbi, "Stopped filesystem due to reason: %d", re=
ason);
>                 return;
> +       }
>
>         f2fs_warn(sbi, "Remounting filesystem read-only");
>         /*
> --
> 2.44.0.478.gd926399ef9-goog
>
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>


>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

