Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88F77BE9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjHNRDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjHNRDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C910C6;
        Mon, 14 Aug 2023 10:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16841614F3;
        Mon, 14 Aug 2023 17:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC698C433C8;
        Mon, 14 Aug 2023 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692032590;
        bh=I/QrwZvW/F2dBANd2wDS+DNx6z+LPkRNA/j6IGl1lD0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=eiP/TIONq3bJEm8ASI9bjWQ49wyxLtzqmuzoqXhA1gWbkG2PoitnYAxUpD8+GaH4k
         T41cTc8pfOvNIJb26S4XeqdAe6a5l07cDbjmdO8g0WiljTyrPIRuAX21iKjhtw0hu+
         BmwbdZMTcVmkhQsOH7/c3TAQYfafjM0Z7nl30YbHXyf/rHqRYuI2zAO7BkbXUqXkMN
         03FeOMc0DlxICStPkDMwWwe+ePaQJCl+c304p9QqCyQylQOyL0yP3hKBxZkTGW1uLV
         tXopdfXGh/aShdb3rjSyGq8BJ4gEO0wJjqfxEmiLiSJnPOSPGjsYiwKpTU0VoNHJgz
         +3e37TtXPhgcg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 20:03:04 +0300
Message-Id: <CUSFHQGJ3I8F.WBL3ZYT3U5FB@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>,
        <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
        <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
        "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH v2 02/13] integrity: Introduce a digest cache
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
        <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
X-Mailer: aerc 0.14.0
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
 <20230812104616.2190095-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230812104616.2190095-3-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 12, 2023 at 1:46 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce the digest cache, a structure holding a hash table of digests,
> extracted from a digest list. Its pointer is stored in the iint of the

What is iint? I honestly don't know what it is. I first thought that it
was "int" typoed.

BR, Jarkko
