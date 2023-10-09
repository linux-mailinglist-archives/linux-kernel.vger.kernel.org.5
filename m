Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C487BE6DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377294AbjJIQqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376970AbjJIQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:46:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8A5AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:46:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf55a81eeaso31177785ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696869981; x=1697474781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BER5/II7QEZwLppFswh2or4Xbt/VYhxLFWZawyoWRo=;
        b=mIfiaRlME+bHI7gUp7tCK5igw0QxKTltnqcbshK6OMlElzPwAQkR3ENgoS0pc4LS0+
         9zVRWSFOAiW8E9Nd1Zmgxc0w5drycUmKQZ8GDHymX6e/C21TmfZvR2ZzvQxdpXszs79E
         MHhO6Vq71h/WwZTYlaLJ9HKHF9wFWmgtrCk3pJzGfFDtjLyvlZzbfvRQ2DmFgOyqlrdm
         8jgTt/ubxnQGKS6R9d7w04+ufLkuFiV18UkaSaySaogZrndtiXqjPvUViU3cfHS1Yvxp
         rBWE/sC0NHZ8pQWSAvTNSIloeH/Isr/J5ATRgBtTd+lKwHiIA90HoxeTFEkp0p0j/fzA
         da9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869981; x=1697474781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BER5/II7QEZwLppFswh2or4Xbt/VYhxLFWZawyoWRo=;
        b=sWj3/wSzSgilNvqdUO0oRwnRXLl1bgAg6L3+/Afib9GIDe8dVWSeiAVZ4kdr9m76tM
         0+EWplYJ5qMYeNIeHdvKAGQwJtzBv3q7kqdnq1ynbznACkBLqLgDY4vVLuigaT6/2FnJ
         Cjl/VhiQrU8DMzCbGKmcwaBPNWyYU38hdsMP4axGU9BFAWLK20+UrHJtFKDG5+hmg0Z6
         QL9az9bucLmAkN8Up7SvbHSNdzb1Gimfsnq2M4KVC/3zmpBDo2QKcKHxwyi9FzsFRqE8
         pZ0ixjKz5cWobFow6mipc4DCuEdHY3e5UiSsZBLNIsxO8v12d+NfIC8bX1APATENDEMm
         c3jA==
X-Gm-Message-State: AOJu0YzfNXf8uLkT2Kc+Sflt5qITav1znJmUX7vTyjjoO4Vm9bU3NwNv
        2ZgGEDB3in+EwHBvEC9aEAQ=
X-Google-Smtp-Source: AGHT+IG9u46clWhDQ/orJIYTBC3GrLDta2su8Xfke2fxRDH82KtpVIHgUDDmx2hQPL7L6dlOo0acHA==
X-Received: by 2002:a17:902:ea82:b0:1c7:48ea:86ed with SMTP id x2-20020a170902ea8200b001c748ea86edmr14380214plb.62.1696869980759;
        Mon, 09 Oct 2023 09:46:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cced])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b001b8c6890623sm9889445plb.7.2023.10.09.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:46:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Oct 2023 06:46:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Use the kmem_cache_free() instead of kfree()
 to release pwq
Message-ID: <ZSQuWl_B_7i0ZW7Z@slm.duckdns.org>
References: <20231007113541.8365-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007113541.8365-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 07:35:41PM +0800, Zqiang wrote:
> The pwq objects is allocated by kmem_cache_alloc(), this commit therefore
> use kmem_cache_free() instead of kfree() to release pwq objects and also
> make use the correct tracepoint("trace_kmem_cache_free") to trace the
> release of pwq.

This isn't wrong. kfree() can be used for memory allocated with
kmem_cache_alloc().

Thanks.

-- 
tejun
