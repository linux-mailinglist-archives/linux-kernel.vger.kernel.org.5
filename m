Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3514803E9A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjLDTnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDTm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:42:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B73CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:43:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C18C433C8;
        Mon,  4 Dec 2023 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701718985;
        bh=APRVnppDxg+3ZX+/Grp1+0OoD5lB8M8Nkp19j9S2qhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dT30pWNUPNx5szzJXbiC4d7qZfM/NcpO25RRG5TEnDhCoN7+EPrEH6psXv7DT3bNA
         aslTpuM7PXA9X+jFMXOxx0EUzHEiLa5s0AT4e6dYPddB7wpqXz6JkohwCo7mmaiKZh
         ScQjk2IH32jeMTAFAEjp6g7xeLPDwy0XjZNvH9Uf5bBVXVUd4QjJmz8KsKtJBmMaIv
         SLzWoV/uIHXuHPLmY8UZQ1gklh1paYFBKRxxxsEJsq2o+QavKK0URZezWNS3aClD7/
         74u+N1WDjo2h8o1Th5BEQHx1qtqJUJ+GrXDwgJ4+utyhT6p7XrKbl84wxTLkVonqgn
         RmUEezqmls9ug==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A2A440094; Mon,  4 Dec 2023 16:43:02 -0300 (-03)
Date:   Mon, 4 Dec 2023 16:43:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 0/2] Cache the arch specific stderrno routine
Message-ID: <ZW4rxvSSfJigYRAd@kernel.org>
References: <20231201203046.486596-1-acme@kernel.org>
 <CAP-5=fWJMcJb0+Nmkd1=HoOc5j7LEzGkJmqyAgdpfekOJtjybg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWJMcJb0+Nmkd1=HoOc5j7LEzGkJmqyAgdpfekOJtjybg@mail.gmail.com>
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

Em Mon, Dec 04, 2023 at 11:10:54AM -0800, Ian Rogers escreveu:
> On Fri, Dec 1, 2023 at 12:30 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Arnaldo Carvalho de Melo (2):
> >   perf env: Introduce perf_env__arch_strerrno()
> >   perf env: Cache the arch specific strerrno function in perf_env__arch_strerrno()
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, stamped the patches with that,

- Arnaldo
