Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17FE769527
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjGaLqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjGaLqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:46:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62046E68
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:45:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686be28e1a8so2860577b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690803946; x=1691408746;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eixVz+lC2CT7QVfWGuIxIWOZy5K4rUiP49mRPzTth6c=;
        b=VT13zwPYUAOAfBEH3rgUxFldZISumpumgvx/iD+w+BPKXFCSw3sb4v14W/QgLOOhbW
         Y4qIeqO4CObDAuwhvipQAF/Nxwdfy7bhGuyOdCPdgvA74GZiUNA7YMGM2eJh0mgKpjun
         mbuYrgNQg2POZNYGwztFta3wBsE1ysU2dL3o/0F2XgHLPdsBU4kATSfglaZu9LdweHrO
         bc9/9LGBiT2538a98gFqSDRWXk4QjqRgfxoau2+N8CLFE5sgcBFdagXToM/WS7YhLx40
         aAfi3jZsaDNavimHFkfpKR1AsIE9HlF8UzHi7DX9PX+WONweh99kzIdKxsN7CAlxRgQ/
         uYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690803946; x=1691408746;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eixVz+lC2CT7QVfWGuIxIWOZy5K4rUiP49mRPzTth6c=;
        b=XsSq3uU6MhgFJ/1+MDY67/Y3y3bZJOG9Eaze7gnJBM0Z/n/jz0kf2aDGyaN81JSk0t
         9qdQBPTWBAc05EZgRMBbryl4k7bjA2vumKXHZN+Aj+Md1gXJovjB7zHxuU7jwNZ5RRBL
         4QEG//9g2HuCKHFdtRhlcgQnVxBEPyMvbT36UJlFn+shYwk+fzQfDfgPjXn81inhEIT0
         2QjJiEoY3hsgYRz+YZyJbotP3g/XRFMNRF5eQFCpM1n+egyzkV60MxYzZHM4/S43idDt
         5bWV2ahNmWBjB6W0xWotctjl9UinBbXFQ/f2evCpnpgIc3TYwahf6MjLu2aZ6Io/fQBM
         AHKw==
X-Gm-Message-State: ABy/qLa/f7Ye0HOKkMw3z94sXOHF8p6xmypHSEtJOTr4gqZSjAcXge1y
        TvzZOTPDiIH44W69uOqCJaSWqw==
X-Google-Smtp-Source: APBJJlGydmwkyBJiOoqdphaZJq4iW3Nm7CDrOuaHl7TUuebUj9EajXLsR+UqO8/g3DIuDKwJOE5j+Q==
X-Received: by 2002:a05:6a00:194b:b0:677:c5bf:dccc with SMTP id s11-20020a056a00194b00b00677c5bfdcccmr10108630pfk.19.1690803946336;
        Mon, 31 Jul 2023 04:45:46 -0700 (PDT)
Received: from [10.90.34.137] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id n9-20020aa78a49000000b00668652b020bsm7440809pfa.105.2023.07.31.04.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 04:45:46 -0700 (PDT)
Message-ID: <ab4422ae-f923-1424-bb10-c345de059f3f@bytedance.com>
Date:   Mon, 31 Jul 2023 19:45:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH 03/11] maple_tree: Add some helper functions
To:     Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-4-zhangpeng.00@bytedance.com>
 <20230726150252.x56owgz3ikujzicu@revolver>
 <ZME23DS/Elz2XPey@casper.infradead.org>
Cc:     mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, michael.christie@oracle.com,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, avagin@gmail.com, surenb@google.com,
        brauner@kernel.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <ZME23DS/Elz2XPey@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/26 23:08, Matthew Wilcox 写道:
> On Wed, Jul 26, 2023 at 11:02:52AM -0400, Liam R. Howlett wrote:
>> * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
>>>   static inline
>>> -enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
>>> +enum maple_type ma_parent_type(struct maple_tree *mt, struct maple_node *node)
>>
>> I was trying to keep ma_* prefix to mean the first argument is
>> maple_node and mt_* to mean maple_tree.  I wasn't entirely successful
>> with this and I do see why you want to use ma_, but maybe reverse the
>> arguments here?
> 
> I think your first idea is better.  Usually we prefer to order the
> arguments by "containing thing" to "contained thing".  So always use
> (struct address_space *, struct folio *), for example.  Or (struct
> mm_struct *, struct vm_area_struct *).
There are disagreements here, so how to decide? But I don't know if the
new version still has this helper.
> 
