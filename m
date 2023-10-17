Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990B77CC17B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjJQLF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjJQLFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:05:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428A5FF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:05:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40790b0a224so4957805e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697540751; x=1698145551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiUZq92UBxC15IpKeVPOwaCF2WD76dOx+OyrOjWWdV4=;
        b=ZtzSD7KPYlh6t8yhi6gar2LPZfgkg66IESqB1rRE5nZ7Sw+MyuXDMalAAoQZaVO48a
         1l6QILSy34noZ8B9owh1n6N0MMf+q3xVt/dBZ+Oploj30tiwA1nlwMIQRQAAvaZmsX9e
         +JfznmG+w6DFsvhUo9ccOIbh6SQH4173bEWhr070p5MpwyFN3UWnGytemNEEDmIQ0tWh
         KGGq1pov9gyYpzZ8jeSzZUTzfxyWk7pnj2YdcrKsTJ/HfjxvoPQuCtMir8qCKgpXRMGg
         4Y7BT8Dm+63Z2/B8iLDHFibSMxfXlx+Ox2ty5r3hgAML+LMO6jW1l+P72vWQG99fZ74t
         xlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697540751; x=1698145551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiUZq92UBxC15IpKeVPOwaCF2WD76dOx+OyrOjWWdV4=;
        b=BGGxM1hZ5Vc7DyOLHGAQMXs0ymqEbkEy+sKHaADXDuXiIKnbn9D7R1KUM2B0VrsmYK
         uOHFBaqhULVOWvKS3Xo13Hxsyo9Z8xdzfHbHY++myD6nIY4yKjFrBkWeh4zu9jRqfWYz
         D0gu00ydjteb/PZcpBMRxYvoJ+UILdTNalbUodRNKKOuR5sSBEMDcOt8Twd33oGmZpHa
         h5pX2sjHyQJck16QM0L5yJlLZckwt+Fnm4Qdvkl4QMaz1/LRhoaV3RvxDG1Of5xl9F6U
         vZoAb0hJapFPoevvWjT2x8ZHwXdZGHHBOnoQ3qkeHw8xCYD3R9GYvaFyKd5hi/wpbhx8
         4I2w==
X-Gm-Message-State: AOJu0YzCy8X8Mqpo0CRy2aNwUdsG6WmVA+eTrI7r8vHUMmTkol9z1ZYZ
        SwzjsRq1ylTIh+lboa9z+9eYel/WAT4=
X-Google-Smtp-Source: AGHT+IH8r10O9qZ3UlDxUNvskTPcQQNlonwgioxQmDJv+zEZx4FHDGV2/5GTWzEwPptLNjzJCJzwOQ==
X-Received: by 2002:a05:600c:a01:b0:401:bdf9:c336 with SMTP id z1-20020a05600c0a0100b00401bdf9c336mr1601636wmp.27.1697540751352;
        Tue, 17 Oct 2023 04:05:51 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id t2-20020adfe442000000b0032dbf99bf4fsm1421171wrm.89.2023.10.17.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:05:50 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:05:49 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Sachin Sant <sachinp@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [powerpc] Kernel crash while running LTP (bisected)
Message-ID: <84a6c480-f29b-4a73-bbb0-4908145dc4db@lucifer.local>
References: <81C9E2C1-DCC3-4DDD-8466-069893398B5B@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81C9E2C1-DCC3-4DDD-8466-069893398B5B@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:46:07PM +0530, Sachin Sant wrote:
> While running LTP tests (getpid02) on a Power10 server booted with
> 6.6.0-rc6-next-20231016 following crash was seen:
>
> [   76.386628] Kernel attempted to read user page (d8) - exploit attempt? (uid: 0)
> [   76.386649] BUG: Kernel NULL pointer dereference on read at 0x000000d8
> [   76.386653] Faulting instruction address: 0xc0000000004cda90
> [   76.386658] Oops: Kernel access of bad area, sig: 11 [#1]
[snip]
>
> Git bisect points to following patch
>
> commit 1db41d29b79ad271674081c752961edd064bbbac
>     mm: perform the mapping_map_writable() check after call_mmap()
>
> Reverting the patch allows the test to complete.
>
> - Sachin

Hi Sachin,

Thanks for the report but this was triggered in another test previously and
has been fixed already (apologies for the inconvenience!) see [0]. Andrew
took the -fix patch and applied to mm-unstable, this should wend its way to
-next in the meantime.

[0]:https://lore.kernel.org/all/c9eb4cc6-7db4-4c2b-838d-43a0b319a4f0@lucifer.local/
