Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B727F7F2643
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjKUHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKUHW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:22:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510849D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:22:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE98C433CA;
        Tue, 21 Nov 2023 07:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700551374;
        bh=rTUDuCw0+yacO1VkcLXeIh3RHyma9O/gexWOtY1atkE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=mMNLUTLRp90G0p8qEBvndw7PFpfeyjlIgQ4HzPyhnjy1/62WeS+GNT4Iyn2aMsOrk
         JPFDHLAkbNzPeK9d41gITvmH8sUo7y62gvpS81jfH7NVZJSGe5h/mRQU6XW7xaxmCS
         TwhO/fvRchxY0+okPLx+/yvEJyKL5U7Wogicmj6zoMKlisrhLDHZh8gGWm8zb5LMdm
         X2aPuSgPYuSYlJn9pBg6AgvOmi+8fMeXAcD5XnMvkoOiXaHDQp1tnxuIof+cpWqDNB
         kSa/xPOwxKA5i4MBAXUQWz+ACx9BTCDdmCMgcVVTqKXfqI+2TuG6R76+OogI3OWeA5
         iDJDo+ZlEz+5Q==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id DF16A27C0054;
        Tue, 21 Nov 2023 02:22:52 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 02:22:52 -0500
X-ME-Sender: <xms:ylpcZTWnurYmR8idzEPtriSzAnbz9nyGasSk6OlgWccnwLpyIffG_g>
    <xme:ylpcZbnrhOLjpk0YqBDgIEllOEXndfk340hKfKLrCyshjl4k-jEgnXdfzZNGH0cMB
    Ff6qeHVRXKRSLCXxdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeelvefgudeiheefledttedthfffgfekudegkeelffdtiedvgfevieet
    teekheffveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnh
    gupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ylpcZfbrTJL1Wj2Z7dzzyyRZDVZllpgQ2FtharPzmPcYaPq64dJf8w>
    <xmx:ylpcZeXnaobuhvRmaDGaSf2W3r0E8GtXWYxnhLD8Y9DxhCQLJNNZiw>
    <xmx:ylpcZdk-POFyxRFJ1f3uy81gSDJbHbtHGyDHyO6iuH5PYAdkKEq6ig>
    <xmx:zFpcZR0B15GtGRA_MB4JMve6blPc_4ynSfvQlSJaOmIHmdl2FjUpEGkVBXIfEVT_>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A5E6B60089; Tue, 21 Nov 2023 02:22:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <7f16795c-ec35-4fe5-86e7-6fb36b05cfc5@app.fastmail.com>
In-Reply-To: <202311211441.4LgOiu32-lkp@intel.com>
References: <20231120215945.52027-3-pstanner@redhat.com>
 <202311211441.4LgOiu32-lkp@intel.com>
Date:   Tue, 21 Nov 2023 08:22:29 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "kernel test robot" <lkp@intel.com>,
        "Philipp Stanner" <pstanner@redhat.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Eric Auger" <eric.auger@redhat.com>,
        "Kent Overstreet" <kmo@daterainc.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Neil Brown" <neilb@suse.de>, "John Sanpe" <sanpeqf@gmail.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Yury Norov" <yury.norov@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "David Gow" <davidgow@google.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        "Jason Baron" <jbaron@akamai.com>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        "Danilo Krummrich" <dakr@redhat.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023, at 07:48, kernel test robot wrote:
>
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202311211441.4LgOiu32-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    drivers/pci/iomap.c:27:15: error: redefinition of 'pci_iomap_range'
>    void __iomem *pci_iomap_range(struct pci_dev *dev,
>                  ^
>    include/asm-generic/pci_iomap.h:44:29: note: previous definition is here
>    static inline void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>                                ^
>>> drivers/pci/iomap.c:43:10: error: call to undeclared function '__pci_ioport_map'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    return __pci_ioport_map(dev, start, len);

From what I can tell looking at the header, I think we can
just remove the "#elif defined(CONFIG_GENERIC_PCI_IOMAP)"
bit entirely, as it no longer serves the purpose it originally
had.

It also looks like s390 is the only architecture that actually
uses a custom implementation of pci_iomap*(), and this already has

#define pci_iomap pci_iomap
#define pci_iomap_range pci_iomap_range
#define pci_iounmap pci_iounmap
#define pci_iomap_wc pci_iomap_wc
#define pci_iomap_wc_range pci_iomap_wc_range

so the entire CONFIG_GENERIC_PCI_IOMAP symbol can probably
be replaced with individual checks here, using CONFIG_PCI
as the conditional in the Makefile.

    Arnd
