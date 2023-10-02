Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5055A7B5B8F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbjJBTum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJBTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:50:41 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2361791
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:50:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C9DEF60171;
        Mon,  2 Oct 2023 21:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1696276235; bh=PdHjwL1WGxFjLAs5xkBLB9K3ip5pkE/ZhbqCR/dn5kg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=loLzo1HzXfAn8PuT7klzHQF8anAu0c28BRNZuQDxApI/MUA5PVLRHt6JgkhdUGWao
         tX9jJnzPsd7xkXiVULItIJv81lkPJ11I8gO/+8lHgVxWbbnucUChXwgxx4owqNrWNB
         BTcXeb+hw0N9ckDnwvgq9p50NQRiPeEnpPbNGCycXLqzdBIxXHN2yi3JoKzvtRu8qb
         e8fwBC3wi4ydn8o5p0AZRy8hyELJuD3HuJt5j/ptDGr5ekoUUEKaWhijHSMBwI/jIr
         RPHBGm2TfPBaj4xQZWp1dQr5m38VF4iKY2+ggkn9vHkXut3z+9kOvYIn3vP8HavAPx
         Nki/8LZlglwfg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k2HKfI_psZjV; Mon,  2 Oct 2023 21:50:33 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-91.adsl.net.t-com.hr [78.1.184.91])
        by domac.alu.hr (Postfix) with ESMTPSA id 076666016E;
        Mon,  2 Oct 2023 21:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1696276233; bh=PdHjwL1WGxFjLAs5xkBLB9K3ip5pkE/ZhbqCR/dn5kg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=R8SWSfAz/uhUwSx5/3Zsj+hab1aXv1VRXu8P0OOFZ6npR0BT5TRwvPYqbYTwF/bc6
         3hcMW0umqDbmAm14ZHNLVojtBlnnQyutbIYEmfg8/l2o+XyOuWAz1rYUcHPZ5X7nGW
         KZZtCCfhyvPfpGmysKKSchfYOJwjWveUqhD0f1LQqnXBolG7nUGOfl5sHIwHDuR93p
         EomFMD1L12AMQckA/MnqV7GpGgWE4GDA5zn7J7qwNueVGHnVXG0crJxxezqgLd8+3x
         d6A6NUuXyLYGNt3WAUgqd64FrlJ95Ob8RtgUbuOyThzNrqwuNpnrajNHGkG9rXY59e
         WkrWAJ2UgknMg==
Message-ID: <479379a1-110d-4543-89f0-cb584b74ce22@alu.unizg.hr>
Date:   Mon, 2 Oct 2023 21:50:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: maple_tree: KCSAN: data-race in mas_topiary_replace /
 mtree_range_walk [EXPERIMENTAL PATCH]
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <9c1549f9-78c2-441b-8617-3ea3c080a5a4@alu.unizg.hr>
 <20230922135155.tqrelea66hcj5cog@revolver>
 <5d908c60-88fb-49c0-a150-bfb468eaa513@alu.unizg.hr>
 <20230928195926.ucp7it3c3c75erzk@revolver>
 <5a30110b-2457-4638-8779-baa33326f6a6@alu.unizg.hr>
 <20231002164310.bi62wfekacfxb3ve@revolver>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20231002164310.bi62wfekacfxb3ve@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/23 18:43, Liam R. Howlett wrote:
> * Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> [231001 17:09]:
> 
> ...
> 
>>
>> They say that one patch speaks more than a thousand words.
>>
>> I am just running this little patch that actually silences all of the KCSAN warnings.
>>
>> I cannot tell if these reported data races are the actual bugs, but it is possible that
>> the Ubuntu 22.04 gcc is doing some funny stuff when optimising. In Prof. McKenney's
>> book I've read about the load-tearing and store-tearing. AFAICS, memory barriers should
>> prevent load/store reordering, but not the compiler optimisations.
>>
>> Please find two versions of the patch attached.
>>
>> While mas->index and pivots[offset] in maple_range_walk can change concurrently,
>> I am not smart enough to see whether you expect that in your algorithm or is it a potential
>> bug triggered by GCC optimisations and aggressive Ryzen 9 7950X parallelism.
> 
> None of this is necessary, for sure.

Thanks for your feedback. If KCSAN is giving false positives, there is quite a lot of them.

I tend to believe on the safe side of the Prof. Paul McKenney, but it is your code.

> I will have to look at this when I have more time to investigate.  This
> will likely not be soon, however.

I see. I also have some tough stuff at my day job this month. :-P

Have a nice day.

Best regards,
Mirsad

> Thanks,
> Liam
