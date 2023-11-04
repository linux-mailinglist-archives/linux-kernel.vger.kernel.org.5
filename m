Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AF87E0F81
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjKDM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:58:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B68194;
        Sat,  4 Nov 2023 05:58:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc5b7057d5so26682275ad.2;
        Sat, 04 Nov 2023 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699102723; x=1699707523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wx/J2gGjIG7iPxsbQ8RiVASXEeZtvK2+9qIqh+JKTRU=;
        b=OzlpU3r+PFGgsGBYurnH46QwPInO6Mvlsgq1rHzGUjm/MfUTWBLj7oa1GA7j2GltVO
         +dWeGcdNIq4i/VLatyv/8G/eNnS3W0GtWcUkdOXceCT2nQOq8pnlejxtlITdSU0H0y0Z
         ONNTICz1A2spuFg+w0Ms7YLJnoPw9a8HfCuRwB4icWFpWELIViwtITQ+ZE8XKcq0S/NB
         CC7o4OcWpQrQKITu7ERUN6MM6ffLdMI+Yon/en6hetvYYYQvys9FO662oi5A6pVCXRBe
         w5ywyV7/Y/aN3JRjMlnok3mXvECF3V1AB6My27vfXWcaEtRDXza1t6cYWMjS+uCMvCI8
         aAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699102723; x=1699707523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wx/J2gGjIG7iPxsbQ8RiVASXEeZtvK2+9qIqh+JKTRU=;
        b=lmV8QP38c76pxXCT4nL8bj1qLYbf/wbSSitts4bpb4xkHSHOYssEQIg2IqUFSKrQcD
         gG9galSTQCJ5/Ph5ewVjvdzmpQNFzCrvKHT3rorWVZyQwNV/Gyo5+cSrulHHyuGzbtFY
         bE2nKoRlk/BSMT4Y1tKNS2Q4umpIRBfXh66qNhsRvSsQe37j6Nx9g/iSz6g7/Y1V/tin
         yriW0YqN6oEJIhNHB6zykkvYdTePLpNbsIfO+44eklFCNJ4WTUbESD1k2g8YM/YcNDdP
         kWoBYB0TpzFR32V0ENRtmi1EPRLXkwGxkLWv831TDwehOVUIhTdgnNRyQIuChgltZ31Q
         VK0w==
X-Gm-Message-State: AOJu0YzEjL3NTZFA8BTBm+Vlu2a2JnuhkxyMKdYy/lRQo61P6sDy7zNM
        +h7vFDwk6Nb1N2Orw8QgCg2Mc5CKN3g=
X-Google-Smtp-Source: AGHT+IHvDkgX6K8vGdHLtjbcSIX6/lZDmWhjB4+CPW2fj6W96iJrymMnFkamCRANHgWtjI7U40WkUQ==
X-Received: by 2002:a17:902:da87:b0:1cc:548d:4252 with SMTP id j7-20020a170902da8700b001cc548d4252mr19211508plx.57.1699102723253;
        Sat, 04 Nov 2023 05:58:43 -0700 (PDT)
Received: from [192.168.1.11] ([27.5.100.249])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b001ca2484e87asm2922354plh.262.2023.11.04.05.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 05:58:42 -0700 (PDT)
Message-ID: <11739388-1f97-4dd1-91e7-c2b0becfb75e@gmail.com>
Date:   Sat, 4 Nov 2023 18:28:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reiserfs: UBSAN: array-index-out-of-bounds in
 direntry_create_vi
Content-Language: en-US
To:     reiserfs-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        syzbot+e5bb9eb00a5a5ed2a9a2@syzkaller.appspotmail.com
References: <20231026125616.1859-1-bragathemanick0908@gmail.com>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <20231026125616.1859-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/10/23 18:26, Bragatheswaran Manickavel wrote:
> deh defined as an array of type __u16[], and issue is
> triggered when it's trying to access an element at
> index 1, which is out of bounds because the array
> has only one element at index 0.
>
> Reported-by: syzbot+e5bb9eb00a5a5ed2a9a2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e5bb9eb00a5a5ed2a9a2
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>   fs/reiserfs/item_ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/reiserfs/item_ops.c b/fs/reiserfs/item_ops.c
> index 3a5a752d96c7..ccf547c5e8e1 100644
> --- a/fs/reiserfs/item_ops.c
> +++ b/fs/reiserfs/item_ops.c
> @@ -484,7 +484,7 @@ static int direntry_create_vi(struct virtual_node *vn,
>   				  vn->vn_mode);
>   		dir_u->entry_sizes[i] =
>   		    (j ? deh_location(&deh[j - 1]) : ih_item_len(vi->vi_ih)) -
> -		    deh_location(&deh[j]) + DEH_SIZE;
> +		    deh_location(&deh[j - 1]) + DEH_SIZE;
>   	}
>   
>   	size += (dir_u->entry_count * sizeof(short));

Could someone help in reviewing the changes. I see reiserfs was marked with
obsolete but still wanted to know whether this patch is correct and can be
taken (if possible)

Thanks,
Bragathe

