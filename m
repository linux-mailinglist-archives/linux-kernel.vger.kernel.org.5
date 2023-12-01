Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ED7800974
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378488AbjLALMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378442AbjLALMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:12:39 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B00193;
        Fri,  1 Dec 2023 03:12:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9D9A43200C4D;
        Fri,  1 Dec 2023 06:12:44 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 06:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701429164; x=1701515564; bh=3PIXt5ZSJzKEQon5QjhjcyxonBykzWc4ulB
        U/OMwHv4=; b=rZRhAFATTfRt7GEYbOWyQPKFDhdG2lttpkqE0maaWMeoM76jWir
        3rBVgTCSI2fyjLbtlvFieAI4GDOvZ7nTwJtqkoBo91h6H6+KGvyyhVr0ErZyZ1Hr
        1Ueagy+LtN0nxnvU/BwsOHWpL5KM3Sfc2q4Or4JQYGRNAyN3Ky7f/igJdJ02pY8u
        4dHb5FhU0AhSvwxAtBAWyMM5mIaGc96/aLwnW6HltAo1IfoQ6EwD0iZWk8jvJ9m3
        zvX5q+kOjV+YL7Y5abFMPsnitv8/Iq4NT6a7nv9esTBu3+hVGkR4Kapd3mvvrj5N
        cYuSwn2im7AZX8Diyq62KPKdHBMcHp59Pdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701429164; x=1701515564; bh=3PIXt5ZSJzKEQon5QjhjcyxonBykzWc4ulB
        U/OMwHv4=; b=S0f1uCIIbRvPR3EALIbaFmH2sQFI09j0Wstna+LmB9U9CSd3v2/
        tNANe/1nO3MJimrexFGd7ZziImhssfEANl7CA6DgKynZuEqy+Pkac5BLuRWn+/mc
        pxK5BfqpNviwS6za3/5vp9Lsa9TICx0gIaFdRpOe2/mywJXBpIixRWol9ltmk8qm
        JoHrZa1NkaIUopZAWU6GD98T+zATeWmHnyTgyY+lJv65ajpt2reyX5BeoTL5mjlH
        +IXWvwtZDKHVRz3XrLwId3l12G11zxeSmaZhXAnFqZ6fAsG0v+lt/Hp/UBdrae7z
        QY3GqgQFoSQgC6HMPd9fdRIkCK7DojRQXfA==
X-ME-Sender: <xms:q79pZZv1bFWbDrH2JKLW-tXP6Q2i_hIVGRkdjuPgBRFW1fKhX11kwQ>
    <xme:q79pZSfx52BOxAOYYV6zHoftt05bFORuDrmvUoQR0V2rxU-UZGO7GYya4PmlC3nAV
    RK_IdlsAAMJUf07Jgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgudejteevuedvjeeludefffdvieevudehueetfefh
    udehvdetvdfgudejtefgvdenucffohhmrghinhepuggvsghirghnrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
    rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:q79pZcwPv77L9ydMrS_8_0FY9NzXnCBLZNrZAPSNfMslowiMNBQUjg>
    <xmx:q79pZQNufpwJBWh3vv3kBWVRQcv-j4tuzFD6JpxEyIVO9WLQFIcXTQ>
    <xmx:q79pZZ9Ns3lQgwGvQjg6veD7_Pd9tpBSMt8T_n9AXgNm4xVHVxvInQ>
    <xmx:rL9pZbLPGMMA4IF2H--qMpxmznhWCN4S0QIt6G6OCzB21YxABeR3Sg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3B48136A0075; Fri,  1 Dec 2023 06:12:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <6f290f4b-5dc2-44f3-9f2d-01496f78d629@app.fastmail.com>
In-Reply-To: <20231130163601.185270-1-tsbogend@alpha.franken.de>
References: <20231130163601.185270-1-tsbogend@alpha.franken.de>
Date:   Fri, 01 Dec 2023 11:12:21 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Aurelien Jarno" <aurel32@debian.org>
Subject: Re: [PATCH] MIPS: kernel: Clear FPU states when setting up kernel threads
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8830=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=884:36=EF=BC=8CThomas Bogendoerfer=E5=86=99=E9=81=93=EF=BC=9A
> io_uring sets up the io worker kernel thread via a syscall out of an
> user space prrocess. This process might have used FPU and since
> copy_thread() didn't clear FPU states for kernel threads a BUG()
> is triggered for using FPU inside kernel. Move code around
> to always clear FPU state for user and kernel threads.
>
> Cc: stable@vger.kernel.org
> Reported-by: Aurelien Jarno <aurel32@debian.org>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1055021
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Perhaps
Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

As well :-)

Thanks
- Jiaxun
> ---
>  arch/mips/kernel/process.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 5387ed0a5186..b630604c577f 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -121,6 +121,19 @@ int copy_thread(struct task_struct *p, const=20
> struct kernel_clone_args *args)
>  	/*  Put the stack after the struct pt_regs.  */
>  	childksp =3D (unsigned long) childregs;
>  	p->thread.cp0_status =3D (read_c0_status() & ~(ST0_CU2|ST0_CU1)) |=20
> ST0_KERNEL_CUMASK;
> +
> +	/*
> +	 * New tasks lose permission to use the fpu. This accelerates context
> +	 * switching for most programs since they don't use the fpu.
> +	 */
> +	clear_tsk_thread_flag(p, TIF_USEDFPU);
> +	clear_tsk_thread_flag(p, TIF_USEDMSA);
> +	clear_tsk_thread_flag(p, TIF_MSA_CTX_LIVE);
> +
> +#ifdef CONFIG_MIPS_MT_FPAFF
> +	clear_tsk_thread_flag(p, TIF_FPUBOUND);
> +#endif /* CONFIG_MIPS_MT_FPAFF */
> +
>  	if (unlikely(args->fn)) {
>  		/* kernel thread */
>  		unsigned long status =3D p->thread.cp0_status;
> @@ -149,20 +162,8 @@ int copy_thread(struct task_struct *p, const=20
> struct kernel_clone_args *args)
>  	p->thread.reg29 =3D (unsigned long) childregs;
>  	p->thread.reg31 =3D (unsigned long) ret_from_fork;
>=20
> -	/*
> -	 * New tasks lose permission to use the fpu. This accelerates context
> -	 * switching for most programs since they don't use the fpu.
> -	 */
>  	childregs->cp0_status &=3D ~(ST0_CU2|ST0_CU1);
>=20
> -	clear_tsk_thread_flag(p, TIF_USEDFPU);
> -	clear_tsk_thread_flag(p, TIF_USEDMSA);
> -	clear_tsk_thread_flag(p, TIF_MSA_CTX_LIVE);
> -
> -#ifdef CONFIG_MIPS_MT_FPAFF
> -	clear_tsk_thread_flag(p, TIF_FPUBOUND);
> -#endif /* CONFIG_MIPS_MT_FPAFF */
> -
>  #ifdef CONFIG_MIPS_FP_SUPPORT
>  	atomic_set(&p->thread.bd_emu_frame, BD_EMUFRAME_NONE);
>  #endif
> --=20
> 2.35.3

--=20
- Jiaxun
