Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD36758806
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGRWCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGRWBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:39 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1881BE8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-765ae938b1bso567670685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717683; x=1692309683;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QmIwKGt94jYf2KPhLSmFgzaycmtKEmxw+WrnIbvuIso=;
        b=Mbf2Q/liSLRvxFKfozzteIVjYxPToGmjZHFHOZqTAPmOscTSZqEd3MWg+c1JPbQ5AU
         vJRhnCqmEqPOR2xhb0of6b+I0NCXvIz7IDC+XPvELeKJQ5jjIssOOTOysaA8KXb3AI0g
         xrsIKxVpdjV81Re4nJc2roQaVdJPMEWtpfg8jY1RcadrxZmHJApUbLsasC0Huj9sT8Q+
         3AtgVpTkmWKfN/+wtYMPDD2UhBdZ8wv5w9FAd5O0KMdP03OUnd2lCmNp+2T1jA9wRo3j
         5KR7VyXZYSZ0UwS2+KSEnl2F/EtH8CwhDkKhyV+3iv2xFll4GxW7ABd8IOiReaQ/meae
         Dg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717683; x=1692309683;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmIwKGt94jYf2KPhLSmFgzaycmtKEmxw+WrnIbvuIso=;
        b=Dl2AIx4lNwwludz7z9dNZ9W92xH/lsEZhDo8dTb5DYSfUHd+PrOhoQH8QYfGBX9i4x
         xLhIK6wf7j58o7b+xhyQgm8KX4K2ftim90+5ELi2weQBKC/Ye8QhJen5A3vkUkPnwotd
         i4zslLcPHr+rwXdtm7dYpuB856SpgE1xzEYn/CHCvk/LKaqWuaYkcUR9fRk6tcaZ6tAc
         ehhziyFkGfTyrNuyryaOGFUCriQTLEhlewkKEQD3Yt0d4tPHhZ/jrvsyrJ2u+GDfpswF
         8VTDe5EcgfDeBiR0KzL/f7wnmPox1pEdu3ID4KfAPUeFf5tj5Zen6zyamvX8QDjd98Vo
         RKRg==
X-Gm-Message-State: ABy/qLaRUNfpC3Jm8fe4vt2Zg0cDjH7JOMApGjj6vKIKiHMuKMltj/OO
        MpTFM/odIN0tHUjESgGpG6wl
X-Google-Smtp-Source: APBJJlHhGq1tjlZnHVP+QBXotZg4yUdiA8CXqpw3+rpOHTZWk1FyertTgnHj6Pq8ZvWd3+aQeC5aXA==
X-Received: by 2002:a05:620a:4113:b0:767:26a4:ab3d with SMTP id j19-20020a05620a411300b0076726a4ab3dmr22111093qko.19.1689717683486;
        Tue, 18 Jul 2023 15:01:23 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm897168qkk.1.2023.07.18.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:23 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:22 -0400
Message-ID: <70576e61aa86aa522409b9a56a62063b.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 12/20] selinux: hooks: avoid implicit conversions
References: <20230706132337.15924-12-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-12-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the identical types in assignments of local variables for the
> destination.
> 
> Merge tail calls into return statements.
> 
> Avoid using leading underscores for function local variable.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
