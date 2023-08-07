Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B83772558
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjHGNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjHGNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:19:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893B4B3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:19:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso624410666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691414364; x=1692019164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJJrvD/G9JTxhkHQHH1bGUg27rSaJAiqqO5viUJTjQc=;
        b=OubUae7D5dFyrm+J+1BdPm0HxvypQANTVeNS01zzb0cZgE+sfyYY9wgtXLHTnNKebj
         HiTKnTsCd1LsISGObIZzSxRUXP/SapP955hm9kiP4TtOhXr6yDcryx+o5HwqClrlBK83
         ldcp5TqiNMLHoiskun8vvb/8Vx12rKIUTEa9tOLNNRnYZakHYoSvFg9zCyn67jkYk2Ta
         lacmrzynspZ8ZTkZg47TB2xRgMGuskAla0Q+EJV/pVJGSwb0KiVhlWSfxrXzrviejJxd
         Xda/I/2KZX53XxRydUQ6wWlmNXwPn+DAB3ULIpR64dry/Zhanqosa1d2Iie9To1oZQ/L
         QCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414364; x=1692019164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJJrvD/G9JTxhkHQHH1bGUg27rSaJAiqqO5viUJTjQc=;
        b=TOz9kBI8AB9PjKkq7Hghx+F8TlMb3NzMlOO8aOCIZwBR8NAZ+4GuR7WEFxYxvwPuhY
         XCOwcjEbg/s7LMhqtkJI7w3ZZ2MZMdF1hpl3MBZJxKlSZqA2s8rEjTat1+94+3aYdcl7
         6bIiSZFlsm2vk6lU9VUGN1PJTMXjgR27g9qFEFbL12MOJ2aXA9tVv+bI6iUgfQ7afOT+
         z+77t8M/NVwtY7Vd2FrJVtq9M40LMO7JJlL6AD4o55DXwxLaXYECcMAnGJTgvc7LRUGY
         h30Rs2EEVMQsPxAkneFn6krPfIQrDKxPfWhcXJZqLXgg8tJykwpmpgWW69riqkTRwThv
         au5A==
X-Gm-Message-State: AOJu0YzefHgkw4eY4T2hWcaTaOMTaLvxI7gIFCgLFKkCZwDhdipUXV7b
        r0r2htNDWTCgi8OPhf4Vyl4=
X-Google-Smtp-Source: AGHT+IGexcOw9OTpTSxtU/vNVu0HkNeyOnSx4BEJl7C/iVOA+SPKFlbwi0l/WdKJIbM6+humbhvVPQ==
X-Received: by 2002:a17:906:538b:b0:974:771e:6bf0 with SMTP id g11-20020a170906538b00b00974771e6bf0mr7141044ejo.56.1691414363798;
        Mon, 07 Aug 2023 06:19:23 -0700 (PDT)
Received: from andrea (host-82-57-177-142.retail.telecomitalia.it. [82.57.177.142])
        by smtp.gmail.com with ESMTPSA id bt20-20020a170906b15400b009929ab17be0sm5152584ejb.162.2023.08.07.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:19:23 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:19:18 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Message-ID: <ZNDvVlbubtOoto0p@andrea>
References: <20230803040111.5101-1-parri.andrea@gmail.com>
 <ZMvLoI6PxLR8RJvR@andrea>
 <4bf79f06-4593-134a-04dd-b8f89e96a1b8@efficios.com>
 <ZMxDe0gXKYbY5jgt@andrea>
 <65350c17-3fcf-a057-a280-f6a5d36dcb21@efficios.com>
 <ZM0STfpkRSfNQBt8@andrea>
 <ab562167-e4a5-4a7d-7722-a4f99848d63e@efficios.com>
 <ZM1OhJY8/PZ/osTH@andrea>
 <e17900b8-ad20-e5c1-2443-0f9559f1fdb8@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17900b8-ad20-e5c1-2443-0f9559f1fdb8@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> One more noteworthy detail: if a system call similar to ARM cacheflush(2) is implemented for
> RISC-V, perhaps an iovec ABI (similar to readv(2)/writev(2)) would be relevant to handle
> batching of cache flushing when address ranges are not contiguous. Maybe with a new name
> like "cacheflushv(2)", so eventually other architectures could implement it as well ?

I believe that's a sensible idea.  But the RISC-V maintainers can provide
a more reliable feedback.

  Andrea
