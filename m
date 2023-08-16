Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D955B77E9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345848AbjHPTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbjHPTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:42:34 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2AA1FE1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:42:33 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bbdddd3c94so5310194fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692214953; x=1692819753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07PYkB4G3AOm6QX4hQQVUrV8lzQpSdLxBnUDHRkXFr0=;
        b=P4Ojdij4NE5WSr9t6zrjOBs4l1Z0chJtTEFeIDAvKhl9VXKTmbKx/RYU7byWKm4Bfk
         ZH1LXox/CXg/HR4GtHpLsJgBi9C+m8eZy1TeJRyn3NV8eOcOG9KCo8nJ7SvzZ3QE9YKJ
         JzgZZgLz0bIbVaiBGmdsXSFsa7dk//U1LWw2zfFQO5Mx1hpgrVQt6rJa/loJUvdomSjv
         OzzSHksqUVRh9poR3nVahS9VneWWdkgaE2IMmFsLbN0OLx+WvVDFbxVXeWhSBGpmntrj
         /9LeU2spzuuyt7BejJ9ecV71CbxhLSSY4fCbwCL9ncXCAE8u2+LmOrua8z/ROTa7fZjU
         G8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692214953; x=1692819753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07PYkB4G3AOm6QX4hQQVUrV8lzQpSdLxBnUDHRkXFr0=;
        b=RmExoH3g9bU2lWlgdxwwKmULaUyTw5y0+4FzvPvz/xcjXkeYwrANFryjGKqYCmDsxB
         MLYZwy7IMRNu1ri4cP9sSErGZYZfOt/mHH+2rqh4c5VcUs5PfB0/B6xDgIJkRfvZUXj9
         OCNp8lvEFXSBU3zHXIUE/lLbmlezWVHzBZmD683DZ0wl+zx/jZjiAu2pAyOg3FigS/S2
         9nHAmlZWnyiVGBpfDqrnNWkkVhGjh9ElkTeNnf2Zja2/6WXVbkgBijeRtVWqNKlRlEXY
         oLYgUXyTh5ao13oR2A7YSrbsSk0b8cHYEFgKD55T96CQMmAMJqo6SygSwM+AaIUHpnlh
         eH+w==
X-Gm-Message-State: AOJu0Yx+Th/pybNDC+4cfaTMbooJZsgPNaEsbv1yrndBL3MbeBXZ52iv
        d1rm6PXiIOhkTafxIuoKz7M=
X-Google-Smtp-Source: AGHT+IEPsphKLNcuLxpXYsFxwwRQ9xceYW4f7iDKZ2pbcrVM89Abkp+sv+h5pTvX01fz8vlvduEz8w==
X-Received: by 2002:a05:6870:a11a:b0:1c1:a011:5cb3 with SMTP id m26-20020a056870a11a00b001c1a0115cb3mr3489079oae.12.1692214952784;
        Wed, 16 Aug 2023 12:42:32 -0700 (PDT)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id eb16-20020a056870a89000b001c4b473581fsm5974185oab.12.2023.08.16.12.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 12:42:32 -0700 (PDT)
Message-ID: <653f62d4-277b-7cdb-39ba-03e0e7dfc1c0@gmail.com>
Date:   Wed, 16 Aug 2023 14:42:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] driver core: shut down devices asynchronously
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>
References: <20230816154518.3487-1-stuart.w.hayes@gmail.com>
 <20230816155435.GA18922@wunner.de>
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20230816155435.GA18922@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2023 10:54 AM, Lukas Wunner wrote:
> On Wed, Aug 16, 2023 at 10:45:18AM -0500, Stuart Hayes wrote:
>> Attempt to shut down devices asynchronously, by making a tree of devices with
>> associated work and completion structs, to ensure that child devices are shut
>> down before parents.
>>
>> This can dramatically reduce system shutdown/reboot time on systems that have
>> devices that take many seconds to shut down, such as some NVMe drives.  On once
>> system tested, the shutdown time went from 11 minutes before the patch to 55
>> seconds with the patch.
>>
>> The code could be simplified by adding the work and completion structs to
>> struct device, but it may make more sense to not burden it with that when there
>> is likely enough memory to allocate this at shutdown time, and if there isn???t,
>> it just falls back to the current synchronous shutdown.
> 
> Please wrap the commit message at 72 chars.
> 

Thanks

> Is there a particular reason why you're not using the infrastructure
> provided by kernel/async.c and <async.h>, such as async_schedule()?
> It wraps all the work_struct plumbing and also has helpers to await
> completion.  I imagine using that might reduce LoC in this patch.
> 

Not a good one.  Let me look into this, thank you.
