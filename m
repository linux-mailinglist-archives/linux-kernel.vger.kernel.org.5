Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA907A13BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjIOCR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjIOCRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:17:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD8826AB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:17:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2684e225a6cso200313a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694744270; x=1695349070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZoHnjqbtxyoT00zY+yvVt56U2UHEZvOnPOttiwSNwMA=;
        b=feQAW3OcACkCvhSXxMa5ZH4HlzKs2AnF+9tWe/YJh1+mKvP2KxXoOdZcbuQW3klpFD
         Eemuh0YpZW9jOka4X3w/BNcyXyJk6k++jf05KR/JmaV4LQKvlOdm2lIoVAP/jBZkKh7S
         XySM/iYMDrA+vBOm9fOH2L4JKCjOU3I5PaoVwM3bi7bxpuIO51tq/rsEG5GTA+n3g4vy
         lfhnSsp2aDYJw1EnVZDWkm3YpGrPKlqrLQ7Eh5Uh1xEBHf46nnKUT73EHopuQ6rDflkR
         0ao1JrK+l++GxCE/Dof0O0d1LjTjEPUcME5Nw7FXlPug5OC1BB0xcAyZFyZwtIZhKPGu
         6bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694744270; x=1695349070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoHnjqbtxyoT00zY+yvVt56U2UHEZvOnPOttiwSNwMA=;
        b=IjaaTcUCUnTvHEa+rhJiWf1INhm3Ftb0gNty8emO5K1ekjHGheRT2oBRLiNYJfFnm9
         ew8UlBZECAjaKprfOFEdr0pxqSbvckQ+k62E2Jxz90aiNX8MxCeRK1c9KnuHojfD0C2g
         OhJ0eS8yyUw1ai+yLPe+3r/jh78pBnoIkJdGQyOUX0JE3fhzMNxHYGVLfnjZlyie35bv
         Diz/djq8LIsgfgkSJrEynj5F7qrd2qhILb2O4d0602LZRB98yjgsjbH2pAXr0i3VgCzO
         7v0WeZAHDuXymZhnReW+RnNV7KDLQDlZG33xFSr8frFLQ9PxyMlRx06CWZFi5QZJ94bi
         mAsA==
X-Gm-Message-State: AOJu0YypMxaRBGlLdMSWd2gr0C/yyX7AD+5saj6D6XPBAbRFpwQ/gq7O
        2jOjOpt/lphKLXQuYv5xaIqgHw==
X-Google-Smtp-Source: AGHT+IFlDvDvyNJEv69o8q3qvbyHShhhCcIO9L8nnAGn3WgucN4i3B33ro22aDhSlfFxOirJ8GnIag==
X-Received: by 2002:a17:90a:7483:b0:273:e4a7:ce72 with SMTP id p3-20020a17090a748300b00273e4a7ce72mr247084pjk.3.1694744270439;
        Thu, 14 Sep 2023 19:17:50 -0700 (PDT)
Received: from [10.84.155.178] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id h29-20020a63385d000000b0057764ccdd0esm1782720pgn.49.2023.09.14.19.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 19:17:49 -0700 (PDT)
Message-ID: <51ae860f-fc8d-fc76-d326-68308e98bf7d@bytedance.com>
Date:   Fri, 15 Sep 2023 10:17:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: linux-next: manual merge of the btrfs tree with the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230915091421.58207f2c@canb.auug.org.au>
 <20230915094731.076a3e98@canb.auug.org.au>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230915094731.076a3e98@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

The diff looks good to me.

Thanks,
Qi

On 2023/9/15 07:47, Stephen Rothwell wrote:
> Hi all,
> 
> [Forgot the diff ...]
> 
> On Fri, 15 Sep 2023 09:14:21 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the btrfs tree got a conflict in:
>>
>>    fs/btrfs/super.c
>>
>> between commit:
>>
>>    c0824542e4d1 ("fs: super: dynamically allocate the s_shrink")
>>
>> from the mm tree and commit:
>>
>>    2ebed4689ba2 ("btrfs: open block devices after superblock creation")
>>
>> from the btrfs tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
> 
