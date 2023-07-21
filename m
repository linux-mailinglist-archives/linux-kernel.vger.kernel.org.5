Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C375D63A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGUVM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGUVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:12:17 -0400
Received: from smtp.rcn.com (mail.rcn.syn-alias.com [129.213.13.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566B63A8E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:12:11 -0700 (PDT)
X-Authed-Username: dG10YWxwZXlAcmNuLmNvbQ==
Authentication-Results:  smtp01.rcn.email-ash1.sync.lan smtp.user=<hidden>; auth=pass (PLAIN)
Received: from [96.237.161.173] ([96.237.161.173:54288] helo=[192.168.0.206])
        by smtp.rcn.com (envelope-from <tom@talpey.com>)
        (ecelerity 4.4.0.19839 r(msys-ecelerity:tags/4.4.0.0^0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
        id 57/A4-05333-7A4FAB46; Fri, 21 Jul 2023 17:12:07 -0400
Message-ID: <6e006cd2-181e-bc68-7eb7-d59d162ef3c7@talpey.com>
Date:   Fri, 21 Jul 2023 17:12:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
Content-Language: en-US
To:     Paulo Alcantara <pc@manguebit.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Steve French <smfrench@gmail.com>, linkinjeon@kernel.org,
        shaggy@kernel.org, linux-cifs@vger.kernel.org,
        krisman@collabora.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230628232417.120844-1-linux@treblig.org>
 <ZK80mu/YbHLEABAB@gallifrey>
 <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
 <ZLhchajZaWEVM6D7@gallifrey>
 <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
 <d1f7fbe9-8fe2-e3e3-d6ff-1544204202ff@talpey.com>
 <ZLnJzUynpTBvZGtA@gallifrey>
 <f8f4a2c5-05d3-0b2d-688f-b3274a98fc73@talpey.com>
 <ZLrxYzGXJzsLmGDs@gallifrey>
 <16f50dff126af9b20f9b99ca056ad5fa.pc@manguebit.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <16f50dff126af9b20f9b99ca056ad5fa.pc@manguebit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdduheefucetufdoteggodetrfdotffvucfrrhho
X-Vade-Analysis-2: fhhilhgvmecuufgjpfetvefqtfdptfevpfdpgffpggdqtfevpfdpqfgfvfenuceurghilhhouhhtmecu
X-Vade-Analysis-3: fedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgj
X-Vade-Analysis-4: tgfgsehtjeertddtfeejnecuhfhrohhmpefvohhmucfvrghlphgvhicuoehtohhmsehtrghlphgvhidr
X-Vade-Analysis-5: tghomheqnecuggftrfgrthhtvghrnhepfeekfefftefffedvieegheektdeuveeitddvgeejudeiffff
X-Vade-Analysis-6: feevkeegvdduveetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptghhvggtkhhprghttghhrdhp
X-Vade-Analysis-7: lhenucfkphepleeirddvfeejrdduiedurddujeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
X-Vade-Analysis-8: rghmpehinhgvthepleeirddvfeejrdduiedurddujeefpdhhvghloheplgduledvrdduieekrddtrddv
X-Vade-Analysis-9: tdeingdpmhgrihhlfhhrohhmpehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehptgesmhgr
X-Vade-Analysis-10: nhhguhgvsghithdrtghomhdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghp
X-Vade-Analysis-11: thhtohepuggrvhgvrdhklhgvihhkrghmphesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshhmfhhr
X-Vade-Analysis-12: vghntghhsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhkihhnjhgvohhnsehkvghrnhgvlhdr
X-Vade-Analysis-13: ohhrghdprhgtphhtthhopehshhgrghhghieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
X-Vade-Analysis-14: gidqtghifhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Vade-Client: RCN
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/2023 5:06 PM, Paulo Alcantara wrote:
> "Dr. David Alan Gilbert" <linux@treblig.org> writes:
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl#n3737
>> 	if ($realfile =~ /\.(h|s|S)$/) {
>> 		$comment = '/*';
>> 	} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
>> 		$comment = '//';
>>
>> I don't get where that idea came from.
> 
> Check Documentation/process/license-rules.rst.

Ok, header files require a different SPDX comment syntax.
I withdraw the consistency comment!

Did I give it my R-B?

Reviewed-by: Tom Talpey <tom@talpey.com>
