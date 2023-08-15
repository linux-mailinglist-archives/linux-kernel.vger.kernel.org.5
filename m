Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8E77CE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbjHOO2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbjHOO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:27:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4044B8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:27:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99d90ffed68so650075066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692109669; x=1692714469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYSzQl/k/Rf6bxTS583bK1exyptODxYufwKUOHcW4LE=;
        b=bAfZgAoNrNwS32o2NHhbFuiKgq1nfBTnjlnqm9JyQYqPR25XvVEjgvZ/aHnZoaKnXv
         09JjgWn5IggP6k6wxTtj+p/UQzY6KlQTLy0J5MU+lHyCuXqxUtUUnmzHekB4NUeioStD
         dAEbTR88D8z3ZjJ/wIQJdi3GGknVRHh+ifSjhaQkMQS1sXkYEkblYfQEj9nAZ5nwSFjb
         Grzf2M9t4IaxTgSxSozYFhVvtvhGwYM1OEKDOcmyTOL9rrqYQ9E/mLZZgjL9POIHashE
         lM+g69ic9vFcEXqmAUOU0+feZizlAbpQj6Feemuf2wRzULZSQG/LgzUA1KSMf/PO8HCq
         E2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109669; x=1692714469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYSzQl/k/Rf6bxTS583bK1exyptODxYufwKUOHcW4LE=;
        b=Ue/xaWjgiyHez9b5Stg4lLtseyO2De/xrJfXfmJKggMfUfK3MQ6bqUsBdaNgnzGWbE
         u2yaFXIUBILfjOvvDhZqFw6vJMPoWZhAwhIe+JAKYR68TM7Jz6EkRmRMC2kBRUaYury4
         AGBVwiySgAEQsVkE0vdTG+W5c4X+fvn1u4n6i24edTTeshLcGuH30k0IXfzmhXQ7LeN6
         hUajTDNmG1G0bLCdLLDbAd/0vwFiQPqzJ67zCLNbnQikLctqvStS6OAtethLPRCEjbo7
         KHHe1fW46g8G6xmZjhpNzNxiJVpLr1wy+e+8wdQgU2RTB3tjeRvE/NU4s8LW4Kh+i3Is
         GbXA==
X-Gm-Message-State: AOJu0YwzzotZ2SIeU4tyKUn1dAsszeG6M7GT2bp5rHlwMdgIHhnG7AU9
        +yH+Bzao9mCKA3aOh0TBPhgGJg8V5g==
X-Google-Smtp-Source: AGHT+IEX1EzhSCo/Qm/CUX5TXVBJqbPFUvPLcEN7UNzmZxv8NVl9Mb0CNcFB2nRqtoR1W44zudkuFQ==
X-Received: by 2002:a17:906:cc46:b0:994:5407:9ac9 with SMTP id mm6-20020a170906cc4600b0099454079ac9mr2204877ejb.5.1692109668970;
        Tue, 15 Aug 2023 07:27:48 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id cd19-20020a170906b35300b0098e42bef732sm7034745ejb.183.2023.08.15.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:27:48 -0700 (PDT)
Date:   Tue, 15 Aug 2023 17:27:46 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm,thp: fix smaps THPeligible output alignment
Message-ID: <9cc6f150-6673-4fe1-a406-e04bc33a49e8@p183>
References: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
 <cfb81f7a-f448-5bc2-b0e1-8136fcd1dd8c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfb81f7a-f448-5bc2-b0e1-8136fcd1dd8c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:02:08PM -0700, Hugh Dickins wrote:
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:    0
> ProtectionKey:         0

> -	seq_printf(m, "THPeligible:    %d\n",
> +	seq_printf(m, "THPeligible:    %8u\n",
>  		   hugepage_vma_check(vma, vma->vm_flags, true, false, true));

Why format string change? It would only slow down printing.

I'd print with

	"%u", +hugepage_vma_check()

or just add whitespace.
