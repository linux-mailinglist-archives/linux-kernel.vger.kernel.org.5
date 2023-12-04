Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B74803D5D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjLDSl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjLDSl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:41:57 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75127FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:42:03 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cbe716b511so3645618b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701715323; x=1702320123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JwMqSnGo4QDjm2pjAxkXN4dZgMZZOVKqtY+jomMdbrk=;
        b=3O97Yzblkyul4rL0GZ9xmqurBw508llq3Otj/rv5MDRvqBDkwaeSdXnG0QsgvYhToZ
         fUDYE3f7vg9n2chE2pyNDZLLk/u+4oSOArLgLNcBQvCHgpBQWKvws15ON2f0jvzyzRtI
         zFUi6wdO2W9udTo+oz0p20S4TueEI/+MOlHLmmhTp7xfa6OQ32chdVB5lgl1HZq9xxS0
         zCUWAQruOjmvXO5aG9OSr48iQo6npUgoeV6E+kq/I4DgOfN0hutf8jGrFPtR724cPnPX
         VLlI67djac5Oq/TJN2wov1X9u0zzPV5TJSeVVK5vwSKvOJAWajwgn7HPLKn3XiudI2Q0
         rqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715323; x=1702320123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwMqSnGo4QDjm2pjAxkXN4dZgMZZOVKqtY+jomMdbrk=;
        b=K1HiTWCVAQgFCPpLOT2BRaBSl2zNp5/oMtgK5f8y+lG1ph0mHYrZpnRpP11G4q/004
         TPl3MCDhQfOD2tAsr3jBERrCdPqO6UjTfbbKJF+fK2bTO4c48Cs3o0ybZCm9cUrkD+g4
         CNwx49tAnvhU+DTiOm4vpi76UvtKJ5AxsIvu9QzHAbycEBCNgcyXJR6vboSybbK4th1p
         kfYK4lc6Ua2bH/7MFlko+QKM+p/CUHf+CufYbE5Jq1EoEk/PrKXbvSdhXgpTVvn/nMpJ
         SVW5NcaCCSaoPJooSOGZSEyzW/NrNfdyHUa4O7/PLqpcL+NeFxqANYGbuQgGN7wR3l4h
         Afdg==
X-Gm-Message-State: AOJu0YyoRnnsEAMqfbajbl6SvyJIXUpt0YccRvP7/deQJT7XdDfKFzSF
        33Z/bXjpWu2LMZ0Vd2NcYTG12g==
X-Google-Smtp-Source: AGHT+IHKEES0EPsD+IyXZ6wxSaPge1KMCqc5mn24C5+zo1vqFwVwrwwwLQ+SFGxsjolXMOrQ4oEdmg==
X-Received: by 2002:a05:6a00:340f:b0:6ce:58d3:34ee with SMTP id cn15-20020a056a00340f00b006ce58d334eemr2724pfb.30.1701715322912;
        Mon, 04 Dec 2023 10:42:02 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id j8-20020aa783c8000000b006c320b9897fsm7954921pfn.126.2023.12.04.10.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:42:02 -0800 (PST)
Date:   Mon, 4 Dec 2023 10:42:00 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] riscv: Safely remove entries from relocation list
Message-ID: <ZW4dePVEM8sslNAJ@ghost>
References: <20231122-module_linking_freeing-v3-0-8e9e412a3305@rivosinc.com>
 <20231122-module_linking_freeing-v3-1-8e9e412a3305@rivosinc.com>
 <87bkbfzddr.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkbfzddr.fsf@igel.home>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:42:08AM +0100, Andreas Schwab wrote:
> On Nov 22 2023, Charlie Jenkins wrote:
> 
> > @@ -683,17 +700,29 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
> >  
> >  	if (!found) {
> >  		rel_head = kmalloc(sizeof(*rel_head), GFP_KERNEL);
> > +
> > +		if (!rel_head)
> > +			return -ENOMEM;
> > +
> >  		rel_head->rel_entry =
> >  			kmalloc(sizeof(struct list_head), GFP_KERNEL);
> > +
> > +		if (!rel_head->rel_entry)
> > +			return -ENOMEM;
> 
> This leaks rel_head on error.
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

Thank you for pointing this out, I fixed this issue in the next version
but forgot to respond to this thread.

https://lore.kernel.org/linux-riscv/20231127-module_linking_freeing-v4-1-a2ca1d7027d0@rivosinc.com/

- Charlie

