Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA30A77A485
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 03:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHMBRW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Aug 2023 21:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHMBRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 21:17:21 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C09127;
        Sat, 12 Aug 2023 18:17:24 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id CCCD88062E;
        Sun, 13 Aug 2023 01:17:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 67EF535;
        Sun, 13 Aug 2023 01:17:18 +0000 (UTC)
Message-ID: <6bfa88099fe13b3fd4077bb3a3e55e3ae04c3b5d.camel@perches.com>
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Zheao Li <me@manjusaka.me>
Cc:     edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Date:   Sat, 12 Aug 2023 18:17:17 -0700
In-Reply-To: <20230812210450.53464a78@rorschach.local.home>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
         <20230812201249.62237-1-me@manjusaka.me>
         <20230812205905.016106c0@rorschach.local.home>
         <20230812210140.117da558@rorschach.local.home>
         <20230812210450.53464a78@rorschach.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: 5bs791sh9hutnjpye58hghrxyso6tnbq
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 67EF535
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+GsV8sVVtK+sokXOxWGGuTVLcWVxIjyBo=
X-HE-Tag: 1691889438-426692
X-HE-Meta: U2FsdGVkX1/tgwy2ApjI4A0qTTSOcR/fQLr3wL6ySPGcZjaRfA1LZ5aCYk4V0pCkbO9o7+tF4vDvgNxTAx2msZDStOSHn1I4kYufzBMD2aHOz8Adujrqb0kk+D604fWZUXs3RpGcPbuYBiOlH4D7NGrDr8RWM/DzIXe/LG5aFrF7p1nucIsUtnR7xQ46nm7A/vYbI8GpOVw47YoTtSv1FHs98XpYuTBQAQW6NDGFfpWd2ry7ky0JRjxj/DZ8Q32b0zjb95QKAE/1jncieeibBaivd/pJH/4Z1hP15l2oX4O0NKkr80inWnCBOj+kPiC4e88Q8nPY3I0GUJ4oMS/x1N648NtlubaW6hJFoJ8FuZveJbwJqdvVDqjnwJ4cm4Ll
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-08-12 at 21:04 -0400, Steven Rostedt wrote:
> On Sat, 12 Aug 2023 21:01:40 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 12 Aug 2023 20:59:05 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Sat, 12 Aug 2023 20:12:50 +0000
> > > Zheao Li <me@manjusaka.me> wrote:
> > >   
> > > > +TRACE_EVENT(tcp_ca_event,
> > > > +
> > > > +	TP_PROTO(struct sock *sk, const u8 ca_event),
> > > > +
> > > > +	TP_ARGS(sk, ca_event),
> > > > +
> > > > +	TP_STRUCT__entry(
> > > > +		__field(const void *, skaddr)
> > > > +		__field(__u16, sport)
> > > > +		__field(__u16, dport)
> > > > +		__field(__u16, family)
> > > > +		__array(__u8, saddr, 4)
> > > > +		__array(__u8, daddr, 4)
> > > > +		__array(__u8, saddr_v6, 16)
> > > > +		__array(__u8, daddr_v6, 16)
> > > > +		__field(__u8, ca_event)    
> > > 
> > > Please DO NOT LISTEN TO CHECKPATCH!
> 
> I forgot to say "for TRACE_EVENT() macros". This is not about what
> checkpatch says about other code.

trace has its own code style and checkpatch needs another
parsing mechanism just for it, including the alignment to
open parenthesis test.


