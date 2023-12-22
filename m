Return-Path: <linux-kernel+bounces-9503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC681C69F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055A9283DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85FAFC00;
	Fri, 22 Dec 2023 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYeZcfL/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D0FBF3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703233721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMjkb+AdlxKmri3rBtLZlSDUhTOTefSe341Yp/i+K78=;
	b=UYeZcfL/cyueZWgU9e/XJgrmYF2nKbCpRQkmThUKsNDu6Yg403FJLfTLLlOdr2HeOBDycF
	THq2b20z+jK6WvXtMdycJcKsyI3KKWa+Cxu7uISd9INob8RSau6u2bBdKYrPEnvxLPgYZa
	ZwF6d3g3B8PNyyHkwrIBAiOGebHZWkU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-MSusXqSPMeuRuUuJ5u3ABg-1; Fri, 22 Dec 2023 03:28:39 -0500
X-MC-Unique: MSusXqSPMeuRuUuJ5u3ABg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cda0492c8eso1549704a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703233719; x=1703838519;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMjkb+AdlxKmri3rBtLZlSDUhTOTefSe341Yp/i+K78=;
        b=Jahnanz0y6kVHLommAMw8Pjo/+PVslEhd0LjF7DJtd/0vTftw/0KuubdzQdbALuMBj
         vkqPNL70PkKazDuoKWz3YkIIx30GonhnCVqeeQFVHHyuLAagNweVD4LoUmrgQNbEScOP
         Jo0UHgNwaHZkuiXQXTe88YlOZNDgGO+8D1I/eIrKXSj+jnbM6NsaUrqtVaKH6x52JFtq
         k6m908v2VNPhzPicGEK5p57veQy4kTNN/YHgAxHSxgAnk9ywM+9S9ByXu4taRuuLtW2h
         RdvO1I+aoy+mgbyxiVmlFKYLCRVLH9a7Hko/VDb3idFMkSbokMZZdNiy7ZOjDHImFp+7
         CZow==
X-Gm-Message-State: AOJu0YyCMhqzBGyQXoU7BF2pDPQQrXwOmdLlN42wbB4zbZNhDa6DcaOi
	YjAFIRCvDyWnh925rn2FoHWWeBiwqGOJ0Fekqk8CCI4tAMTyZhPPt86iHNu+7Wk3fJwZLvmt9cz
	iOiJI80MKsqmgRyC77cQRYNjvxI9muASW
X-Received: by 2002:a05:6a21:19a:b0:195:4690:863 with SMTP id le26-20020a056a21019a00b0019546900863mr45083pzb.78.1703233718835;
        Fri, 22 Dec 2023 00:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG33qrfp2fIVx3SmQWmemCX48oeiSybC38vfzm6VdXRQ5wpTERAGty1KgAqNyi4XHyHs8U0kQ==
X-Received: by 2002:a05:6a21:19a:b0:195:4690:863 with SMTP id le26-20020a056a21019a00b0019546900863mr45061pzb.78.1703233718549;
        Fri, 22 Dec 2023 00:28:38 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:7496:88a7:1b1a:a837:bebf])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78b93000000b006d98ba05776sm657875pfd.67.2023.12.22.00.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:28:38 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greg Ungerer <gerg@kernel.org>,
	Vincent Chen <vincent.chen@sifive.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 4/4] riscv: Introduce set_compat_task() in asm/compat.h
Date: Fri, 22 Dec 2023 05:28:21 -0300
Message-ID: <ZYVIpSVzJYGMYPD2@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTTzOS+16d2sqLnRnw_bxVnE9Gudtf4nu69XbSsvcsQCfw@mail.gmail.com>
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-5-leobras@redhat.com> <CAJF2gTTzOS+16d2sqLnRnw_bxVnE9Gudtf4nu69XbSsvcsQCfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 04:11:10PM +0800, Guo Ren wrote:
> On Fri, Dec 22, 2023 at 3:47 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > In order to have all task compat bit access directly in compat.h, introduce
> > set_compat_task() to set/reset those when needed.
> >
> > Also, since it's only used on an if/else scenario, simplify the macro using
> > it.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  arch/riscv/include/asm/compat.h | 8 ++++++++
> >  arch/riscv/include/asm/elf.h    | 5 +----
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
> > index da4b28cd01a95..aa103530a5c83 100644
> > --- a/arch/riscv/include/asm/compat.h
> > +++ b/arch/riscv/include/asm/compat.h
> > @@ -28,6 +28,14 @@ static inline int is_compat_thread(struct thread_info *thread)
> >         return test_ti_thread_flag(thread, TIF_32BIT);
> >  }
> >
> > +static inline void set_compat_task(bool is_compat)
> > +{
> > +       if (is_compat)
> > +               set_thread_flag(TIF_32BIT);
> > +       else
> > +               clear_thread_flag(TIF_32BIT);
> > +}
> > +
> >  struct compat_user_regs_struct {
> >         compat_ulong_t pc;
> >         compat_ulong_t ra;
> > diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> > index 2e88257cafaea..c7aea7886d22a 100644
> > --- a/arch/riscv/include/asm/elf.h
> > +++ b/arch/riscv/include/asm/elf.h
> > @@ -135,10 +135,7 @@ do {                                                       \
> >  #ifdef CONFIG_COMPAT
> >
> >  #define SET_PERSONALITY(ex)                                    \
> > -do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)              \
> > -               set_thread_flag(TIF_32BIT);                     \
> > -       else                                                    \
> > -               clear_thread_flag(TIF_32BIT);                   \
> > +do {   set_compat_task((ex).e_ident[EI_CLASS] == ELFCLASS32);  \
> >         if (personality(current->personality) != PER_LINUX32)   \
> >                 set_personality(PER_LINUX |                     \
> >                         (current->personality & (~PER_MASK)));  \
> > --
> > 2.43.0
> >
> LGTM
> 
> Reviewed-by: Guo Ren <guoren@kernel.org>

Thanks!
Leo

> 
> -- 
> Best Regards
>  Guo Ren
> 


