Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04447D53B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjJXOOf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbjJXOOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:14:33 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1486A109
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:14:31 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id B44BDA019E;
        Tue, 24 Oct 2023 14:14:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 7F1BC80012;
        Tue, 24 Oct 2023 14:14:27 +0000 (UTC)
Message-ID: <f3bacb7d1da93aee9a549da3b96faa4cb9350b3e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Recognise "Debugged-by" tags
From:   Joe Perches <joe@perches.com>
To:     Michael Ellerman <mpe@ellerman.id.au>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Date:   Tue, 24 Oct 2023 07:14:26 -0700
In-Reply-To: <20231024111714.1814510-1-mpe@ellerman.id.au>
References: <20231024111714.1814510-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7F1BC80012
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: eqc39nishcsg83y9hkbf4qs6kc43o3xw
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19OuAsZtjVqdX/k4kaRNiC7q9ozjd07M70=
X-HE-Tag: 1698156867-311397
X-HE-Meta: U2FsdGVkX1+YwLjmbuMO33jW6DJnLn9o72PpeCDdQCumPiqqrYCebbRFlbuY/y212A+up10TeiXzxjmFy8QPSg4nXVvYiDuqC5AKNzuDHt+qhE/8Dz4omLP4ub7FQ/5wCUH2QjnxTAEBmGonwE21Pd8+lu2tITiNpQnjsi80EvRtQ4CsVWlhRmaBTnkvz3BcuDp3KE58uIK/38UqSsQsom+9VO2RrEgNjM+4bLvON13y2XkZQuSQQQkIbrUcIWdGHmA6N+w6j3truoU2eK5+UgvDLHcygxEYcVH1sIwjSdRgqrj8BKDgsCaK+b6tCC3M+GEhvY4uzyBYw+aqZCPwJqgLYIOQr79cU0t5t19IalRCLHlYK2v5knw0mjgF/XRy
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-24 at 22:17 +1100, Michael Ellerman wrote:
> Currently checkpatch complains about "Debugged-by:" tags:
> 
>   WARNING: Non-standard signature: Debugged-by:
>   #33:
>   Debugged-by: Jane Doe <jane@doe.com>
> 
> There are over 150 Debugged-by tags already in the history, so
> checkpatch should allow them.

nack.

Please do not use checkpatch to change process.
Update the process docs then update checkpatch.

