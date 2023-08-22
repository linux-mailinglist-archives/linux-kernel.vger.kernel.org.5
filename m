Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E47844A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbjHVOq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjHVOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:46:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA99110B;
        Tue, 22 Aug 2023 07:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7882662421;
        Tue, 22 Aug 2023 14:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB3EC433C8;
        Tue, 22 Aug 2023 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692715582;
        bh=QU4HT9SfxsSAFUZSD9YpVgGZx2ZNnyPRcH1B1xpNY1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uwGXrVnJeK0jNwUUVOtx8MDgGx82+boI8zIKr6CRFKju7xXFm56PNlbKriJ2awUeQ
         whK2lnLpzrFtm2hByGAQpfg4/x8QYHBy/zjhW+WAPj24bXeu3kIArCIoD4lbL8JpCv
         RF3G90dW/NZJZQ+DfjbnDrMSwcfOJXuFvG0V6TV3GjW1Qv4BSlTCXpULH+SNSQI8Xh
         xJtdvNtqcsMmPd7xHjTVowwqvIPDg/lRFqBBHIg46LzSUt71jbB50zOjulUb5XdtkJ
         HWFT81DMxHAZmGCoM84KEGYPBrvh1RhvkgdLkLWUm3eDyaVR7FTtOxut4EH1mQz5/L
         HOMfBritfmfaA==
Date:   Tue, 22 Aug 2023 23:46:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5 0/9] tracing: Improbe BTF support on probe events
Message-Id: <20230822234618.0973563d91db6702f118254f@kernel.org>
In-Reply-To: <20230822100716.2dd867e0@rorschach.local.home>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
        <20230822000939.81897c0c904934bfb9156a59@kernel.org>
        <20230822100716.2dd867e0@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 10:07:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 22 Aug 2023 00:09:39 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > Can you review this series?
> > I would like to push this to for-next.
> > 
> 
> I skimmed the patches and played a little with it, but as I've just
> started my vacation I will not be able to do a full review before the
> next merge window. But I don't want me to be the cause of you not
> getting it in.
> 
> Feel free to add:
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> to the entire series. I'm sure I'll be playing with it after it gets
> in, and we can fix any bugs that come up then.

Thank you for your Ack and have a good vacation!
I will continue to test it and fix bugs if there is.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
