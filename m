Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA0B7E8091
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbjKJSPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjKJSOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:14:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846A039CCB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:46:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8973C433C8;
        Fri, 10 Nov 2023 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699627610;
        bh=ADJXJUQ+yQCokhxG3Gpz902vfTvDUZW88gRg9FvUxeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0IMv16WHOf9OHJnWKO+KxsHFlUmJj2cGyUmKPf0XCoXfrBwnDkIJ4l3UwdkLuij6
         Txyc1CeqIGDKWNgIH2xuW5SQ8VtLcs0izPCcEmi4VHJ/or4w9Hjod/jJMxhkpg520r
         TTdEZIO1jLupxlG0c3qnwHgTJs8oMacLr3mQySvN+L5Cm+QbHVYMVDhj084EDaQJcu
         GJBgCCyTDrWw85OJ7QSKfPLBGYbRydNizM/QKZH1P4hQCAp1/vouDq6KLd9FE4moNG
         kYgZ4QKtywyrOLasZnlW5QzjkY0kBI0WbsMy/cnXZhoGmtAT1JPD/f2w09kaRTo3bi
         vH1JKPnEPaqgg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8594C40094; Fri, 10 Nov 2023 11:46:46 -0300 (-03)
Date:   Fri, 10 Nov 2023 11:46:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] perf vendor events riscv: add StarFive Dubhe-80 JSON
 file
Message-ID: <ZU5CVv0U+Q4BmHeX@kernel.org>
References: <20231103082441.1389842-1-jisheng.teoh@starfivetech.com>
 <CAP-5=fW4T_j02RLghg=_OB1TkRWFuHKOR59xFyEsdEH5gGnUPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW4T_j02RLghg=_OB1TkRWFuHKOR59xFyEsdEH5gGnUPA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 03, 2023 at 08:45:33AM -0700, Ian Rogers escreveu:
> On Fri, Nov 3, 2023 at 1:27 AM Ji Sheng Teoh <jisheng.teoh@starfivetech.com> wrote:

> > StarFive's Dubhe-80 supports raw event id 0x00 - 0x22.
> > The raw events are enabled through PMU node of DT binding.
> > Besides raw event, add standard RISC-V firmware events to
> > support monitoring of firmware event.

> > Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
