Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A43805C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbjLEP4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjLEP4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:56:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25924C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:56:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2F9C433C8;
        Tue,  5 Dec 2023 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701791796;
        bh=rxx7r4kYMIc5POiSPA+UFcBMnkPATUU27TPKjCSbTug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrclWcSvdEp8X5JfZi9UsGROvTw1ITfTjKbxGAFZN6AWew4mS9aqtLuSwk5OnGQmo
         HgNKBOeVjU+sSusuEmXpVu+aIGDM1EnHrrGR6ZrGAYQxhx07/7f6qgLu1/E7FmrMby
         LrxF0Pxb3luwfKw7ik9R5Yi6zkSZH1hXkDTmHBql5O8mMlHv9rbeTRV6EIpDbaVCAW
         artsmSS1QY6oLZNih6izkTTqOymOv3v/cxCPEtqsG1cOA34CFIvV/Oj7tpSs+OWDOm
         CnVjAJHKi5aybKcR69es27jKbRIZivWHBAaebs6U9wSmK5VXdcXtxVvlgiPbEkm/ds
         fgMKVN8t5cHWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8F63240094; Tue,  5 Dec 2023 12:56:34 -0300 (-03)
Date:   Tue, 5 Dec 2023 12:56:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Chengen Du <chengen.du@canonical.com>, namhyung@kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: Parse NOTE segments until the build id is
 found
Message-ID: <ZW9IMo44Q+jM4W7Q@kernel.org>
References: <20231130135723.17562-1-chengen.du@canonical.com>
 <CAP-5=fWGfaTwhJRHWUZgRwb4Z16C=zdWWjb8eeQB6PReEtw9Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWGfaTwhJRHWUZgRwb4Z16C=zdWWjb8eeQB6PReEtw9Sw@mail.gmail.com>
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

Em Thu, Nov 30, 2023 at 10:23:31AM -0800, Ian Rogers escreveu:
> On Thu, Nov 30, 2023 at 5:57 AM Chengen Du <chengen.du@canonical.com> wrote:
> >
> > In the ELF file, multiple NOTE segments may exist.
> > To locate the build id, the process shall persist
> > in parsing NOTE segments until the build id is found.
> >
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

