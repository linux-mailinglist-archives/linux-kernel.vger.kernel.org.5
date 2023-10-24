Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952577D46D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjJXFQI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXFQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:16:06 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF872E5;
        Mon, 23 Oct 2023 22:16:00 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 11ACD80D4B;
        Tue, 24 Oct 2023 05:15:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 453B520016;
        Tue, 24 Oct 2023 05:15:56 +0000 (UTC)
Message-ID: <d3ca8db7c045909c9fff6bc3e96a7b8de1b05f8d.camel@perches.com>
Subject: Re: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
From:   Joe Perches <joe@perches.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com,
        oe-kbuild-all@lists.linux.dev,
        "David E. Box" <david.e.box@linux.intel.com>
Date:   Mon, 23 Oct 2023 22:15:55 -0700
In-Reply-To: <8fe01b6d8c558f11fe51f9da5fbfea6708766096.camel@perches.com>
References: <20231012023840.3845703-4-david.e.box@linux.intel.com>
         <202310121314.3Xpqom2w-lkp@intel.com>
         <6ed4cd5ae37a054d4780c8fa519dc83396b15c14.camel@linux.intel.com>
         <b93a3e8-2d15-256a-4172-a22ef17dde9@linux.intel.com>
         <8fe01b6d8c558f11fe51f9da5fbfea6708766096.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: 1bu1s17ue3tkzt64cfiuxtcbzt5z6u8e
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 453B520016
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/BfWXPPjomueLq0tjzk7VysEFwj8EnymI=
X-HE-Tag: 1698124556-615886
X-HE-Meta: U2FsdGVkX1//oFGP91jE454ZqW93elOfmFLV5PdCnnVL2xiBGMydJs+EJJuBAZfq5QcLGfl7aC7XlHwBywypIJ6VXRY+i1EjpIOwVCNZDpe7Qo9hP1J/pame0gzvpmg+ltYZChg8PntfwLWtLaqHxnEiMb/1e1RIYbfuJdej79NBykaUk0yzMuUhD7wzeJ0CdtLAFISGa/s3Fc8LyYdr5mVRPFziKQzzwMAjAftj6z7rHJS94nRne+fG9YQ2CWP5kUoOaMZoLDNYW5/cP6YQge2OMC60Y0+XOy8jOt2jFX20U6b36Fo04H3SVxyDz9wZ
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-13 at 11:14 -0700, Joe Perches wrote:
> On Fri, 2023-10-13 at 13:39 +0300, Ilpo Järvinen wrote:
> > Hi,
> > 
> > I added checkpatch people, please check what looks a false positive below.
> 
> Yeah, thanks I guess.
> The __free uses are very new.
> I'll play around with adding it to $Attributes
> and see what happens.
> 
> 
> > On Thu, 12 Oct 2023, David E. Box wrote:
> > > On Thu, 2023-10-12 at 13:25 +0800, kernel test robot wrote:
> > > > kernel test robot noticed the following build warnings:
> > > > # many are suggestions rather than must-fix
> []
> > > > ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
> > > > #31: FILE: drivers/platform/x86/intel/vsec.c:159:
> > > > +       struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
> > > .
> > > These looks like false positives.
> > 
> > I agree. If I interpret the error message right checkpatch seems to think
> > that's a multiplication which is not the case here.

So __free is an odd $Attribute as it takes an argument.
I've added it along with the other odd $Attribute __alloc_size
to another variable called $ArgAttribute and $Attribute.

Oddly, I don't understand why perl does not perform
the elimination using

	$foo =~ s/\b$ArgAttribute\b//g;

but does do the elimination using

	$foo =~ s/\b$ArgAttribute//g;

maybe something to do with the closing parenthesis in the match.

So now there is a separate substitution for this in a test.

Comments?

---
 scripts/checkpatch.pl | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda1128..501383fa31c55 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -488,9 +488,14 @@ our $InitAttributeConst = qr{$InitAttributePrefix(?:initconst\b)};
 our $InitAttributeInit = qr{$InitAttributePrefix(?:init\b)};
 our $InitAttribute = qr{$InitAttributeData|$InitAttributeConst|$InitAttributeInit};
 
+our $ArgAttribute = qr{(?x:
+			__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)|
+			__free\s*\(\s*\w+\s*\)
+)};
+
 # Notes to $Attribute:
 # We need \b after 'init' otherwise 'initconst' will cause a false positive in a check
-our $Attribute	= qr{
+our $Attribute	= qr{(?x:
 			const|
 			volatile|
 			__percpu|
@@ -516,8 +521,8 @@ our $Attribute	= qr{
 			____cacheline_aligned_in_smp|
 			____cacheline_internodealigned_in_smp|
 			__weak|
-			__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)
-		  }x;
+			$ArgAttribute
+		  )};
 our $Modifier;
 our $Inline	= qr{inline|__always_inline|noinline|__inline|__inline__};
 our $Member	= qr{->$Ident|\.$Ident|\[[^]]*\]};
@@ -4091,6 +4096,9 @@ sub process {
 			# remove $Attribute/$Sparse uses to simplify comparisons
 			$sl =~ s/\b(?:$Attribute|$Sparse)\b//g;
 			$pl =~ s/\b(?:$Attribute|$Sparse)\b//g;
+			$sl =~ s/\b(?:$ArgAttribute)//g;
+			$pl =~ s/\b(?:$ArgAttribute)//g;
+
 			if (($pl =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
 			# function pointer declarations
 			     $pl =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||

