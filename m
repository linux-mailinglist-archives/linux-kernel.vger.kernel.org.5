Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67B77BC122
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjJFV2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJFV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:28:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A391FBF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:28:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98683C15;
        Fri,  6 Oct 2023 14:28:55 -0700 (PDT)
Received: from [10.57.67.92] (unknown [10.57.67.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A3A93F5A1;
        Fri,  6 Oct 2023 14:28:15 -0700 (PDT)
Message-ID: <22ff3362-83fc-46c6-9412-15ca36c51d54@arm.com>
Date:   Fri, 6 Oct 2023 22:28:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
Content-Language: en-GB
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230925200110.1979606-1-zokeefe@google.com>
 <20231006105810.17fcb352e33cbcab1645099b@linux-foundation.org>
 <0ed83331-9037-421a-d450-363e07e87f6a@redhat.com>
 <20231006121105.69a1f32753dad00b993e2547@linux-foundation.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231006121105.69a1f32753dad00b993e2547@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 20:11, Andrew Morton wrote:
> On Fri, 6 Oct 2023 20:52:30 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>> And as I don't know what is the urgency of this patch ("mm/thp: fix
>>> "mm: thp: kill __transhuge_page_enabled()"), I'm unable to decide which
>>> patch needs to come first (thus requiring rework of the other patch).
>>>
>>> Please discuss!
>>
>> IMHO clearly this one.
> 
> OK.  I'll drop the "variable-order, large folios for anonymous memory" v6
> series for now.

Yep, agreed!
