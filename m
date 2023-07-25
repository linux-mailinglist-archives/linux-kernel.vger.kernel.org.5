Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6A4761BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjGYOie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjGYOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75CD1BE;
        Tue, 25 Jul 2023 07:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E4261782;
        Tue, 25 Jul 2023 14:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB3AC433C8;
        Tue, 25 Jul 2023 14:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690295870;
        bh=0Oz8CD4VYFS2ZuWfX7wJBu37DvBUA5Ei6YCtywcVAJ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RjgpozTiR71X12HVv4uWfmqME0LfYVB0EGiFG5NLtDqBAGpAGUmaWsf5EtG6V6p3X
         e/VQ2LwHiX7pN/MP9pZvIZvEaX3ryp7lSbS9qv197eiJMwN4zsU/mklEATWW/zMKqK
         w3tVhignBpyq1RW4ONerAnkJVhqWqgWieGD+oWU85TBKhW03jNvSLMcYhHQ4Qg0hSJ
         rsHsLMIB8WlKIF3W+CpiAndKVp3nIW4kwT9+x4JM3ipBG0Tzvvk9SGtm9d2Fw3ExTr
         IgxLpgA2V4gfM0MBE7dtKa8YWwU/X0cE7EQDhh5hsUgka46+JuZHO3/9TTooGI3Rn7
         9fO0HKpjFiXZg==
Message-ID: <b6ab3c25-eab8-5573-f6e5-8415222439cd@kernel.org>
Date:   Tue, 25 Jul 2023 16:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings:
 net: snps,dwmac: Add description for rx-vlan-offload
To:     Joe Perches <joe@perches.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        workflows@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
 <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
 <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
 <20230721185557.199fb5b8@kernel.org>
 <c690776ce6fd247c2b2aeb805744d5779b6293ab.camel@perches.com>
 <20230724180428.783866cc@kernel.org>
 <213f5d2b13225f9ed4bdadda3c492ffc79940b13.camel@perches.com>
 <CAMuHMdX0DpNSDRSJ7D85NGV2ri2kFHjTtXJE5aOaTD3jNoyc-w@mail.gmail.com>
 <d2f7d5dd-cada-a3a2-2962-9c93d847f491@amd.com>
 <03ace72f8c8796e2a2f24a86e089a617daef9688.camel@perches.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <03ace72f8c8796e2a2f24a86e089a617daef9688.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 15:43, Joe Perches wrote:
> On Tue, 2023-07-25 at 08:19 -0500, Mario Limonciello wrote:
>> On 7/25/23 02:33, Geert Uytterhoeven wrote:
>>> Hi Joe,
>>>
>>> On Tue, Jul 25, 2023 at 6:22 AM Joe Perches <joe@perches.com> wrote:
>>>> I do suggest you instead write wrapper scripts to get
>>>> the output you want rather than updating the defaults
>>>> for the script and update the process documentation
>>>> to let other people know what do to as well.
>>>>
>>>> Something akin to Mario Limonciello's suggestion back in 2022:
>>>>
>>>> https://lore.kernel.org/lkml/20220617183215.25917-1-mario.limonciello@amd.com/
>>>
>>> FTR, this is more or less what I am using to generate a script
>>> to send out patches:
>>>
>>>      OUT=...
>>>      echo git send-email \\ > $OUT
>>>      # Add -cc
>>>      # Wrap comment inside $(: ...)
>>>      # Replace (...) in comment by [...]
>>>      # Replace ] at EOL by ) again
>>>      # Add continuation to EOL
>>>      scripts/get_maintainer.pl $* | \
>>>      tr -d \" | \
>>>      sed -e 's/^/--cc "/' \
>>>          -e 's/ (/" $(: /' \
>>>          -e 's/ (/ [/' -e 's/)/]/' \
>>>          -e 's/]$/)/' \
>>>          -e 's/$/ \\/' | \
>>>      tee -a $OUT
>>>      echo "*[0-9][0-9][0-9][0-9]-*.*" >> $OUT
>>>
>>> After generation, I edit the script to
>>>    - Replace some --cc by --to,
>>>    - Add/remove some people,
>>> and run "source $OUT" to send the patches...
>>>
>>> Gr{oetje,eeting}s,
>>
>> My script is great for single subsystem patches as it gets all the right 
>> people but I've found problems whenever it crosses multiple subsystems.
>>
>> Many subsystem owners want to see the whole series of patches to 
>> understand how they interact.  So the group of patches needs to be 
>> treated together which would need the wrapper to look at all patches 
>> instead.
> 
> Which can't really work all the time as vger has a recipient limit
> and subsystem spanning patches frequently exceed that limit.
> 
> bcc's don't work well either as the reply-to chain is broken.
> 
> No great solution to that.
> 

For small patchsets (and recipients list) I recommend:
https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L91

For bigger patchsets - Rob's sendemail identity could work:
https://lore.kernel.org/all/CAL_JsqLubWBr2W3xZPsuPLOGav7CFgBdH=aCfT22F_m0_cx3cQ@mail.gmail.com/
but cover letter has to be treated separately.

Anyway, it is not the case here. This is small patchset and the
submitter should run get_maintainers.pl on *the patchset*, not on one
chosen file. Running it one one file, ignoring maintainers of all other
patches, does not make sense. There is nothing to fix in
get_maintainers.pl. I believe our docs are also correct here.

Best regards,
Krzysztof

