Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7353B8115C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442266AbjLMPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442280AbjLMPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:05:39 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEABE10DA;
        Wed, 13 Dec 2023 07:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0syRyLMAduRkBnFmUBvq2qT/Oe9rAZr7h6oDqIb7iMk=; b=JTXP13yTJE1qIR8YJpDu+CM6kV
        P5N8tFNlWOqyiNeB70fu5+TxcbgrYR34ogDKUT2coknSN7ryMVbmHUPiQdcmwpmZVLQ11kKsBX61c
        /ny6uuPKQ+7mU6lQhehSSz0gcI/19hgmMEPqYItWKR0tEbcfYa3wZtHBuuT0cS9JlePBfbnSrAWHX
        /KwNpgI11HYIZ1/qON0DIyjzgn4Lhza1MPUaV0Zmpb+iaohxBX3iYT8i6kw9PAkdrkReCKPg6p+Hc
        1bdmFLvsOMp0dcCXBEnMLK49IBKz8fsrjIp7fs4gYbBLwPFeJPQ5cdTFQGXnUVJGkcyuujFm8sjPp
        X0Z+Gj/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDQnU-00BoEy-02;
        Wed, 13 Dec 2023 15:05:16 +0000
Date:   Wed, 13 Dec 2023 15:05:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] dcache: remove unnecessary NULL check in dget_dlock()
Message-ID: <20231213150515.GM1674809@ZenIV>
References: <20231106134417.98833-1-vegard.nossum@oracle.com>
 <fb2cf7c5-cced-4ea3-bf5a-a442a0e64bda@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb2cf7c5-cced-4ea3-bf5a-a442a0e64bda@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:40:33PM +0100, Vegard Nossum wrote:
> [Fixed up a couple of bad addresses in Cc]
> 
> Hi,
> 
> I didn't get a response to this v2 of the patch below and I don't see it
> in vfs.git.
> 
> Was there something wrong or is it just awaiting review? Is there
> anything I can do or help with? I would be happy to try to review other
> patches if there is anything outstanding.

commit 1b6ae9f6e6c3e3c35aad0f11b116a81780b8aa03 (work.dcache)
Author: Vegard Nossum <vegard.nossum@oracle.com>
Date:   Mon Nov 6 14:44:17 2023 +0100

    dcache: remove unnecessary NULL check in dget_dlock()
