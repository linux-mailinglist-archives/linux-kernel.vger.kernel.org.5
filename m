Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3EA756509
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGQNcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjGQNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:32:06 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E89A11C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:32:00 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a37909a64eso2775473b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689600719; x=1692192719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HT77U7HJK6Ne07wYJYzEak7BW7vkZwxv/+cQcW7DBkk=;
        b=be5tQN6KGAdAfUJmeDhExzBFM8EOh5k/7tzfVJxZKpjczg1JhNoEFgVHZbufXeYg5/
         pzaRs68Lg/91rSyDfucteQrNgPvkEJ9cgon1Onxe6MGhOtkQUqVAh3Y4KpSlZT97jLyD
         UPrj+1HyuobM4E4AlsgOPGHDOwU/xrDlZeJhE7kAF0ji0MTzb5SK8euk4R4d2zQ+ZSSI
         uZmJ5TWsen/rWm06bOBWkUzKDntUn3MzTFC4njFS75EIEHKrzSF/fHklCG8GVHs9ac2j
         Ys7trc5NmCkOUlmZL2d9PH6LZ9zvgOEK/kNGMPJSzoxQbBHlKtw4+1ATu+KUiywNp22Z
         E0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600719; x=1692192719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT77U7HJK6Ne07wYJYzEak7BW7vkZwxv/+cQcW7DBkk=;
        b=YcsCTVm2oWomJ6uubFdM+CpF/poKYrDqxdeQInRzRArfdxbkUt3PWq1JaUlxK1BhGU
         Va6IM4eaF4/HFHd8vWXQiXealwBnEpOGniWnfsuwivB9eSzCRMWULTO2D70pVaGs1zKP
         F7YYgZhXjBWmF4SVLjIIajZj+Fug4OI2YafT9lSADNwxh4gw328qqOTm7iS9Irgs7+l1
         6nuMCimr295KTcO2kG4lbo/H3XdFbqi9EK0w7dE036PNTthkL80LK5PN6FtEW7i21bK9
         X4W5q6uNujyB5UaXeMJaSKECbQJd4cFfJn6qFVlP+rBK3Unnxot8pURXbDcq7JxarBcc
         syfA==
X-Gm-Message-State: ABy/qLYYZ0Eu03NPG3r/aken2+zOKkeSArxZn+LP/RAowoOhbcp1Btuf
        oT+0a0P/2cD2BUepNYkamyo=
X-Google-Smtp-Source: APBJJlGHMmNMYTGgeA0Hvxt+cNiOjgAJkMxCjSEqSK46oy7eiHT43tMOmXQSBUsE3Pjvo+1kADQvGQ==
X-Received: by 2002:a05:6808:138a:b0:3a4:2545:1cec with SMTP id c10-20020a056808138a00b003a425451cecmr14491390oiw.38.1689600719717;
        Mon, 17 Jul 2023 06:31:59 -0700 (PDT)
Received: from geday ([2804:7f2:8006:9379:516e:42c5:d582:55d9])
        by smtp.gmail.com with ESMTPSA id k7-20020a0568080e8700b003a3b321712fsm6821296oil.35.2023.07.17.06.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:31:59 -0700 (PDT)
Date:   Mon, 17 Jul 2023 10:31:54 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        syzbot <syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] [alsa?] memory leak in snd_seq_create_port
Message-ID: <ZLVCyk17wzowxRo7@geday>
References: <00000000000098ed3a0600965f89@google.com>
 <87v8ekattg.wl-tiwai@suse.de>
 <ZLQ/zKgTGMHy/6Jn@geday>
 <CACT4Y+bXLZf9iAgiLcxo7coNsOCsn_1C26zuvNBa48qLp2Juxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bXLZf9iAgiLcxo7coNsOCsn_1C26zuvNBa48qLp2Juxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:02:07AM +0200, Dmitry Vyukov wrote:
> 
> Hi Geraldo,
> 
> What exactly is cryptic in the report? Is there anything that can be
> done to make it less cryptic?
>

Hi Dmitry,

It's cryptic for a novice only, of course, in the same sense that kernel
stack traces are a pain for a novice do decode. Unfortunately I believe
it's only AI/LLMs that will make it easier to abstract the low-level
details and give a high-level explanation of the bug.

Thanks,
Geraldo Nascimento
