Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F608760B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjGYHUw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 03:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjGYHUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:20:18 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020893C06
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:18:14 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 0AB39A0C5F;
        Tue, 25 Jul 2023 07:18:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 6058720028;
        Tue, 25 Jul 2023 07:18:12 +0000 (UTC)
Message-ID: <bfbbe21efeaff19587a442cb1df121b0e2da46c2.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: strip long text in brackets from mail
 description
From:   Joe Perches <joe@perches.com>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Jul 2023 00:18:11 -0700
In-Reply-To: <20230725070642.2270207-1-costa.shul@redhat.com>
References: <20230725070642.2270207-1-costa.shul@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: fusyaxiqnfa9tc3xgqb169ncph64f5op
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 6058720028
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/WzaDac16hhI5KDbTmgkpzlcelxN0NDus=
X-HE-Tag: 1690269492-970242
X-HE-Meta: U2FsdGVkX19BRjkfuYU3btGaxKaONSTq74sJPeWYYiyH+kxdm6/YUvGdPDyU7Dtk7JcLNz/cbxEr53VbBDnd0x9M3KRkTJDKYBTRmipfanFTGRivyB90AGygumqkrgNbZsPuPCFUrBmG7TnfpaUexIpXsFN2bSTaISvTCrjSokvNOxgnKk4PWC1Fw+OWS8zdwzRYZzsWGizARRPo4oycd969Oe1R+OoN6x58E/bK6Y2PHIsXhIARc0H7yk0rQ8O9STzh2VqKfpbJWdv5u8ah+F68mIUk4qnBI0SO8aIdy6cnw9pi4Lh7epSPKAouN9f6O5lorL7ypcDvZd+2IHj6qOAAeUw6a24qOLuRlJU7Jk6rogoA13idSVQ4/QildFLD
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 10:06 +0300, Costa Shulyupin wrote:
> assuming this text is optional,
> because truncated bracket causes error of git send-email:
> 
> git send-email --to-cmd=get_maintainer.pl ....
> Unmatched () '(open list:CXLFLASH (IBM Coherent Accelerator Processor In...)' '' at /usr/libexec/git-core/git-send-email line 652.
> error: unable to extract a valid address from: linux-scsi@vger.kernel.org (open list:CXLFLASH (IBM Coherent Accelerator Processor In...)

Add --norolestats to your invocation instead

