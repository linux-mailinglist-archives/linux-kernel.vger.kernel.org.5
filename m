Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A966797AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245365AbjIGRrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245350AbjIGRrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436ED135
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:47:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a3082c771so882195b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694108836; x=1694713636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HkNuLpADsq1HxO6p8F6ChifHRIKFqFA3PCMXwO6LXU4=;
        b=Zo8Wmflu33mX0ydth7qvEnXJj4kKAnZSaotrw/tNJKXjepX96JLQDQyqGluhQTIY39
         mj8iVkga9+xvmS2xM/5m5L8hBuquGzXhu8pH8YnRdtW4peO9z3zD0/19pej4i3qbmPrM
         L+u0TN7HUhjIWJqzMKC04n4yUTfddOwQe0qEP1koL64hBFzQQVSMkmgdWRUGGFQcqaRM
         n2kZk724vYAs9R+d0i1Ukc8yHp+jpIAP5q/M8tGIYmx3MwxkW3aU/Y1VVrtfAhimtMYw
         O/0K94KTT8RelaDKSTFbkV5NNeXA6SiXpcb5y03f+Y4cAsChnXQI22rwvMEIREtLmdvC
         4ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108836; x=1694713636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkNuLpADsq1HxO6p8F6ChifHRIKFqFA3PCMXwO6LXU4=;
        b=XT9Lu4Pv/eCzlouAl9QaUzdNEXisT0kenWFdhhbk7e8bOCHil7rdV9oYcgAa6TlvnW
         20Sz97gaqphA73P3nODvDA8rbZRP/vi0CMpR+SQ4jrspbbE+uJrIHm7wxk548oXiK2rG
         msk2ElUCdNd+oCfq6cHFeQ8ikLV/UdsnM+8fgl+5xsrfijdBls/5Ew9iKfTNhc1yDoJl
         2Jbuu98LgOM5oSpIxGMaqXGviJ95pclvcY8P7gdxWnvMIzufHHM8z+ouwOYofBCIdTAS
         5tMllQXrpVSfi7KK695yzG9R8/xFFaseGdgInTGVT9QaRvCk1e0MgS2dVwM3l0jW5Qp/
         uC3Q==
X-Gm-Message-State: AOJu0YyqCHcrneCxjx0HSIpt3208CFF+p4owNPRdxnSrSxxjAqsdWPS4
        dByYXUKRf3Rv81f3zqJebsrr+Q==
X-Google-Smtp-Source: AGHT+IHtGyzHQWdfOQOsK2cxB6aenF+V0LcJKTzFVrUzD4aaSH/IBNPbrk+n11AmEY9FSvaZ0QhLeA==
X-Received: by 2002:a05:6a00:2995:b0:68e:38cf:9de8 with SMTP id cj21-20020a056a00299500b0068e38cf9de8mr3964462pfb.9.1694108836223;
        Thu, 07 Sep 2023 10:47:16 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:84f6:5055:9180:822])
        by smtp.gmail.com with ESMTPSA id z12-20020aa791cc000000b0068844ee18dfsm11025pfa.83.2023.09.07.10.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 10:47:15 -0700 (PDT)
Date:   Thu, 7 Sep 2023 10:47:13 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 2/5] riscv: Add checksum library
Message-ID: <ZPoMoVnUjNzr+OXI@ghost>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
 <20230905-optimize_checksum-v2-2-ccd658db743b@rivosinc.com>
 <20230907-9d5d2e7ef2a20edd75514470@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907-9d5d2e7ef2a20edd75514470@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 10:52:35AM +0100, Conor Dooley wrote:
> On Tue, Sep 05, 2023 at 09:46:51PM -0700, Charlie Jenkins wrote:
> 
> > +#ifdef CONFIG_RISCV_ISA_ZBB
> > +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		/*
> > +		 * Zbb is likely available when the kernel is compiled with Zbb
> > +		 * support, so nop when Zbb is available and jump when Zbb is
> > +		 * not available.
> > +		 */
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop",  0,
> > +					      RISCV_ISA_EXT_ZBB, 1)
> > +		    :
> > +		    :
> > +		    :
> > +		    : no_zbb);
> > +	} else {
> > +		if (!__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZBB))
> > +			goto no_zbb;
> > +	}
> 
> Again, do these constructs have an appreciable benefit over doing
> if (!riscv_has_extension_likely(<ZBB>)
> 	goto no_zbb;
> 
> ?
> 
> That encaspulates the fallback to a non-alternative mechanism for you,
> in case you had not noticed.
I got caught up in the other patch where I did not want to fall back, so
then in this patch I forgot I could use riscv_has_extension_likely. I will
make the change.

- Charlie

