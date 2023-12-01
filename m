Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54AF800D93
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379228AbjLAOn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379235AbjLAOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:43:57 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B265510F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:44:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6FA835808AE;
        Fri,  1 Dec 2023 09:43:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 09:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701441837; x=1701449037; bh=kK
        o4dJKblO+HlaEynT7R0ipo9rNcBzF1TALtacSN8BE=; b=M8oHNdH+cvykmc/+5J
        8RMXWyg22pwYkaY44RoX9SPAkdK1aLBFwwkj4sptf+YpDIdDWuTHixMt9aEH++tj
        kRSLFukS+/iWZDl3Q0aoNgsvZ8NUjDBSh39eGILjEePgB5J6m3aLFYpHYIztcwMU
        jKm81uFGfDBlzWrPt5/0p7DrQTiGlFdjyBx76kxrq+8KsEBvUgXzyCBFFzMl0fNL
        i8wvSsEhMh2XHOhbJ08aVytYJYkjEYgxtRGwAR+RCpNkU4rOpaDvol39QD0QGJDx
        U3QPyA+VAYxSUKSbtQrHD//p9vvDd8gZi+BgknFw5FSC0jNXuHmv9Jf9vMz90S3w
        sPuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701441837; x=1701449037; bh=kKo4dJKblO+Hl
        aEynT7R0ipo9rNcBzF1TALtacSN8BE=; b=gvF3JFrwR29gFH3qJWYjCOqt3lyop
        MwdkBKVOAx3QaD9AsJ+mKQvXRb+g3ZVqwY8+x4NjTbHwwvcebV9LRkL7NEtTJvfE
        3oBykOvMihi81cveRMT/4Uk8DBrNnKptFYiNvuF75XpUEv4CgHRDUFgaBehOJkOI
        HKPkil0zv46wXWPldhcOqaBYlgC4878tbGVMBU3DNpqk0ivMSXm8doZ391JausdQ
        fFXr8GVgKGWxuyXGeJvSfi52quDYp0TAAIcZb59B9ORY1oxRebTGIctziyUCT8L9
        QueLm9VM9VjhHwOyEP8SS6rU/u1TRMV8T3fZ+jj98h2Ed9exim2dstO6g==
X-ME-Sender: <xms:K_FpZT1N2xHpKGa1QK9TszyH0GWiI3A3mc5QjQ6mvf4SwSdYyogiwQ>
    <xme:K_FpZSHN9gNozBunfgMHPgQVu_k_4S9LpYPWbb2yR8qSpXGFeZtG8GpBSt_PiUFSC
    _gurV8FebrnjCjFubA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:K_FpZT5VLRyq7L0J3Ttt9kntPs34rf9ubufIk9CTsTVak8gsEsJoZA>
    <xmx:K_FpZY1r7ldOCyyL10MX5TaoWaBF6Rq9u_LrBIqSGkmrzWMY_9xfIw>
    <xmx:K_FpZWE9ZE1Op-EA9RLa41otswK1gi4T-66MV-A7LPT7wMtyDBJhCg>
    <xmx:LfFpZaNc_koo_gR9hz0jAbAGvo13fDijh0rLvdqL_CRyPBrs1lPr6Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 75EBCB6008D; Fri,  1 Dec 2023 09:43:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <a2b006be-ab4c-4040-b3db-db68d9c77cda@app.fastmail.com>
In-Reply-To: <20231201121622.16343-2-pstanner@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
 <20231201121622.16343-2-pstanner@redhat.com>
Date:   Fri, 01 Dec 2023 15:43:35 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Stanner" <pstanner@redhat.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Uladzislau Koshchanka" <koshchanka@gmail.com>,
        "Neil Brown" <neilb@suse.de>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "John Sanpe" <sanpeqf@gmail.com>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "David Gow" <davidgow@google.com>,
        "Yury Norov" <yury.norov@gmail.com>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        "Jason Baron" <jbaron@akamai.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        "Danilo Krummrich" <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] lib: move pci_iomap.c to drivers/pci/
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> 
> -#ifdef CONFIG_PCI
>  /**

You should not remove the #ifdef here, it probably results in
a build failure when CONFIG_GENERIC_PCI_IOMAP is set and
GENERIC_PCI is not.

Alternatively you could use Kconfig or Makefile logic to
prevent the file from being built without CONFIG_PCI.

   Arnd
