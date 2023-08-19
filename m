Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93087781682
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 03:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbjHSBwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 21:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243154AbjHSBv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53853C38;
        Fri, 18 Aug 2023 18:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E6886179A;
        Sat, 19 Aug 2023 01:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310B2C433C7;
        Sat, 19 Aug 2023 01:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692409917;
        bh=5CvlsXgaTrAu5WqDJYsFlp67N9uRSI15oDB9762NZNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tgvXmm3LhmErZLAS8tF1hCy6+SY5CR/b5tHRq8zK98pwCXCxSb/9MB+VoERVMPrho
         gXA7kmZwvbC5Ua8GiU7DslDBleH+gsx1F7cgWKUEIhXSIPkMLljjtdUch2dNBesqdo
         e9f9eU1rZtmUaL4jjEz2IuX7pzGcaiT5OG3J/pEvv8Z1A/v5gngm1ZLif3xz7KzN9E
         7LIUdLx2shM79G7iKjqMtyY8GwcX5hTA54sAL0/LW6Hrc8EvqSwG3Bjs8KM94OrYCN
         nOq+lMtZc1nvWkQd2VRSQpAOF7u6MGQCdj+kYFYBtFbGNUg4YYqRM8mDuMgneLL6cl
         IfbiU9iNaYZ0w==
Date:   Fri, 18 Aug 2023 18:51:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zheao Li <me@manjusaka.me>
Cc:     edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
        rostedt@goodmis.org
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230818185156.5bb662db@kernel.org>
In-Reply-To: <20230812201249.62237-1-me@manjusaka.me>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
        <20230812201249.62237-1-me@manjusaka.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 20:12:50 +0000 Zheao Li wrote:
> In normal use case, the tcp_ca_event would be changed in high frequency.
> 
> The developer can monitor the network quality more easier by tracing
> TCP stack with this TP event.
> 
> So I propose to add a `tcp:tcp_ca_event` trace event
> like `tcp:tcp_cong_state_set` to help the people to
> trace the TCP connection status

Ah, I completely missed v3 somehow and we got no ack from Eric so maybe
he missed it, too. Could you please resend not as part of this thread
but as a new thread?
