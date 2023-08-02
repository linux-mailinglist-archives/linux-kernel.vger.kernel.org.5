Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F0676C3B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHBDtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjHBDth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:49:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2CD1BC1;
        Tue,  1 Aug 2023 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hqrdnm/XvcXGx4CoVVqbXlCI1yx06HjsI6afQOMMR/E=; b=uDAU8DGIp4xKzrZQCUWm/ggWaS
        5myrCY6iUfJ9WoOC7gPPZzjmCHpYlY8bihWa871eSGTWy5E42am7uR4gty+dCYaLgoVWmLRIcq5d5
        a43HZDUCy+z5zFDR3VaGYo5OuDnUxfvZ2FAfjPc/9HmbKBeN3VtY1z/S3Q5e1dkRw3MIr3sQ2r4+8
        T5+4Y+adBhaVAPXQ9y8H/4JWCqxZxrWUF8GrtVZ69nIf8dXAZrrNiVqfAkcEsaJoroDDIpEh7glvv
        xmiZiEkaGw20v6opkSAXpd9YI3f00BpqoEoAmgGHs9dURbbf0SlBtkajBtihyzVE2qD7MOsPk0QJK
        4iHgecHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qR2r1-00CiGN-4l; Wed, 02 Aug 2023 03:48:55 +0000
Date:   Wed, 2 Aug 2023 04:48:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, openeuler <kernel@openeuler.org>
Subject: Re: [PATCH v3 2/2] rcu: Dump memory object info if callback function
 is invalid
Message-ID: <ZMnSJ86Wg3uWNTG5@casper.infradead.org>
References: <20230802034518.1115-1-thunder.leizhen@huaweicloud.com>
 <20230802034518.1115-3-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802034518.1115-3-thunder.leizhen@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:45:17AM +0800, thunder.leizhen@huaweicloud.com wrote:
> +#include <linux/mm.h>

mm.h is a very complex file with many dependencies.  Don't you really
only need slab.h?

