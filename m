Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00B97931E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbjIEWS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:18:26 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 15:18:22 PDT
Received: from cmx-mtlrgo002.bell.net (mta-mtl-002.bell.net [209.71.208.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE7F4;
        Tue,  5 Sep 2023 15:18:22 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [142.198.135.111]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 64C354070390BE13
X-CM-Envelope: MS4xfFGp7K8fsjwAIkKxkkTCB1D4DbUpr1yNdSob22zvO32kDaJJRUChJ32P0eV8iUnwus0K7pU11bBkZaMnP1kL0ivGNaXCW+hmQo0LPyz0aw0TXZqjBSt6
 JKmEcwpyELUrT6g5YwPzJQOTFWi3If/GIplholArMoTvg07okxfTC3ICxBYWnq7YL1O9d98gx064IWy1vMMD9UV1l5zi2wMchakeYYCC2/oLWIOqN+690cA5
 pbU7khLbLk+rEQd/HBGc4D5A7uRGnfYua94xltaR72Am1rN51N9f8fpky5JQVCvtItUZvpyS2SN0g2ju18SEgnNwke13eN4IuHEYkKZblHWGWgXW2p9dGAK7
 2jLiYTrRDJ2rwKs5Ne7U1PrDODB5w+HjO7PvFAkvDvRPVLUGOWW6AR47d/iJT+ynB+EZwRB+A3pyU/7EeGCnEbGuv8neAQ==
X-CM-Analysis: v=2.4 cv=QbcFAuXv c=1 sm=1 tr=0 ts=64f7a849
 a=m0hBPjpnfWKpZW+YOe+Hqw==:117 a=m0hBPjpnfWKpZW+YOe+Hqw==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=lSKOu3fFmukTdTWYJJQA:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (142.198.135.111) by cmx-mtlrgo002.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 64C354070390BE13; Tue, 5 Sep 2023 18:14:33 -0400
Message-ID: <122c0f7d-8f76-0f88-e12e-90a50478ec38@bell.net>
Date:   Tue, 5 Sep 2023 18:14:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <20230905190828.790400-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-05 3:08 p.m., Masahiro Yamada wrote:
> I checked the assembler output, and noticed function references are
> prefixed with P%, so the situation in parisc64 is similar to ia64.
Function references are prefixed with P% when they occur in data like the following:

     .dword    P%func

This causes the generation of a function descriptor.   The assembler and linker can't handle the P%
prefix in other situations.

Dave

-- 
John David Anglin  dave.anglin@bell.net

