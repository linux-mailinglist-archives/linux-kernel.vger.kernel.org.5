Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37ED804334
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbjLEAVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjLEAVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:21:01 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA2A10F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:21:07 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00f67f120aso672409066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735666; x=1702340466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLC67jYq1zrTa9b74MVVKlqFqmV1Kih6WvNWfIs1/Ao=;
        b=YX/ermrcQfMYsHj/2iUiImNNAd44wJvFzQCSiKBLAqi7xdYabyCDawANL9tr+rIQ3i
         IuTTSpc3Bz/H1lfQrRmnclaU8I5Nns7bbJn/yoGaxNMIUsoce6qSvwBxRhdc+EE0R1lM
         oxFYDKaHhuon2H/gFMHoO+Q7ciF5UnfonvlK+wYMD2dPvFYdT9FpGOtXxgXYfKP69X82
         +Uw72Xa0cNg+i22sxv4KYBhnZb2buAaHrW9pi3NWtA8iKJUNWAzHKDoDqAfmLfwhub93
         pGfJiYSJmSSCwVsn8DxhXXvdho1M2wKJBzbUDWRO5L1PzolSegOjnb8tHehPApD67z++
         Fgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735666; x=1702340466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLC67jYq1zrTa9b74MVVKlqFqmV1Kih6WvNWfIs1/Ao=;
        b=r67+D9BobOU+Tce3cJ5ITJDuT1NCVZl7avRNMJemXJrmSueniRUn+PfHOsHK32thTq
         bI3GFHfQSC9CsXlE8nPTPGfq+hMpKFQefMBrxHe8fgqVNMVnCthb0850Vobj3vx2RDx1
         XmAeKIUccfO71ONRjYNtcJ80XekfNfWPrzWhFQeme14+0zbK3pK/77AYYkHGPTqDXog2
         oC7X7FE7QHjan5D//YfQ6Y11BAqKc4XAm/gWOMZWQ9KI/2XMV3aYdpwZGzAx0cNKvoj7
         TxrcVIwRGo0s4c5xmGWh1CJMNWPCoyuJT0zKEPF6k6+nVnv6ZuMw4oNcRH8t3J5xm+X7
         ZDNg==
X-Gm-Message-State: AOJu0YzDebnLEpsp/FpYhpL5bZz1e/PEbrgZw3ScQQeZ6bxCRpsRb1z9
        kjS9Q42wJZ28LP1I7051JuQ=
X-Google-Smtp-Source: AGHT+IHryeyPiqO3RNTwgYdBeHqIQj6jp1OvxkbvBD6O6U9as2934Z4PrdM0ZNtws+U3Ss8oijDzcQ==
X-Received: by 2002:a17:906:5649:b0:a19:6d13:885e with SMTP id v9-20020a170906564900b00a196d13885emr3487299ejr.75.1701735666165;
        Mon, 04 Dec 2023 16:21:06 -0800 (PST)
Received: from mail ([87.66.46.106])
        by smtp.gmail.com with ESMTPSA id f20-20020a1709067f9400b009fd7bcd9054sm5928522ejr.147.2023.12.04.16.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:21:05 -0800 (PST)
Date:   Tue, 5 Dec 2023 01:21:04 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip v3 3/3] x86/percpu: Avoid sparse warning with cast
 to named address space
Message-ID: <eeteyctnyvcmmss72uj3dx7tci2c3glif3qe3fz5657v2eg7sh@wlft3mifqweu>
References: <20231204210320.114429-1-ubizjak@gmail.com>
 <20231204210320.114429-3-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204210320.114429-3-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:02:31PM +0100, Uros Bizjak wrote:
> Teach sparse about __seg_fs and __seg_gs named address space
> qualifiers to to avoid warnings about unexpected keyword at
> the end of cast operator.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310080853.UhMe5iWa-lkp@intel.com/
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
