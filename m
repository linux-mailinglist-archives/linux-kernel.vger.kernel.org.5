Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19D811321
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjLMNlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjLMNkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:40:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FEE895;
        Wed, 13 Dec 2023 05:40:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D0B5C15;
        Wed, 13 Dec 2023 05:41:45 -0800 (PST)
Received: from [10.57.85.231] (unknown [10.57.85.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03A183F762;
        Wed, 13 Dec 2023 05:40:55 -0800 (PST)
Message-ID: <6479439f-181f-4c99-b8ae-72fe2ee569ee@arm.com>
Date:   Wed, 13 Dec 2023 13:40:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/23] Introduce runtime modifiable Energy Model
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <CAJZ5v0gqAGv50MK9oAVW=+w+7unavQ86cHF6zmyJjmVvNYjzUg@mail.gmail.com>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAJZ5v0gqAGv50MK9oAVW=+w+7unavQ86cHF6zmyJjmVvNYjzUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 12/12/2023 18:49, Rafael J. Wysocki wrote:
> Hi Lukasz,
> 
> On Wed, Nov 29, 2023 at 12:08 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> [...]
> 
> I like this one more than the previous one and thanks for taking my
> feedback into account.
> 
> I would still like other people having a vested interest in the EM to
> look at it and give feedback (or just tags), so I'm not inclined to
> apply it just yet.  However, I don't have any specific comments on it.

I do have a keen interest in this series, but mostly from the point of 
view of uclamp. Currently uclamp is able to send hint the scheduler to 
bias task placement. Some CPU cores are known to have very different 
energy efficiency depending on the task. We know these tasks beforehand 
and can use uclamp to bias to certain CPUs which we know are more 
efficient for them.

Personally I've always been wondering if this could just be reflected in 
the EM itself without emphasizing on the task placement aspect of 
uclamp. The idea of this series LGTM and I'll take a deeper look.

Hongyan
