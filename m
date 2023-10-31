Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B87DD4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345476AbjJaRiD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjJaRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:38:02 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A9E8F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:38:00 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id C3EC614054F;
        Tue, 31 Oct 2023 17:37:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 769DD2E;
        Tue, 31 Oct 2023 17:37:56 +0000 (UTC)
Message-ID: <bb0be69b3d4483a9e8a29bedca9e1117a42e40f9.camel@perches.com>
Subject: Re: [PATCH] staging: vme_user: Added blank line after declarations
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Rohit Chavan <roheetchavan@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Date:   Tue, 31 Oct 2023 10:37:55 -0700
In-Reply-To: <d94519dc-8e2e-427b-9828-4f714d0561a1@kadam.mountain>
References: <20231031100610.5394-1-roheetchavan@gmail.com>
         <d94519dc-8e2e-427b-9828-4f714d0561a1@kadam.mountain>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: s8hwmqg7or3yfsm3hceq5mpkyw5b89g8
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 769DD2E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Y4Lk5Ohe0duQ7Weqxvd7e66sww4hsK+w=
X-HE-Tag: 1698773876-869344
X-HE-Meta: U2FsdGVkX1/+yg2e3ycIbFUpTqfxJW+WHsv8ya/jnYXVh4yCEPg0y+kcguw6Jg+rPpeQixm7CyarqEHh643ZGgo7S9UTy6j55/ajH0Gi4ndmPsDJpPHhA4PpHsoRKzqPYcs1YUtGa8x9Wc2lpYh212UfcxE3OyGjo7oL9oVoSCPSsI2zBOL2i76j46LMRBtRY4MelopTT9Y6J3kxpeqkvqgUQ7Jn/BfFo7Lv9c06nwFs2wmT3ulrAMskVedBeXDo1plGg60xGeJyDFgLdpxS0mi8s7llSlP5OvkNnvuBAsMkjBZ590hj1+tQdi3r9z6LhLrrm1UcJ9b5CFeWMVojxovus+Fgucwo
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-31 at 13:27 +0300, Dan Carpenter wrote:
> On Tue, Oct 31, 2023 at 10:06:10AM +0000, Rohit Chavan wrote:
> > Fixes below warning reported by checkpatch.
> > WARNING: Missing a blank line after declarations
> > 
> > Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> 
> This is a checkpatch false positive.  (It's not "after declarations").
> Just ignore it.
> 

checkpatch could accept function pointer and function pointer arrays
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda1128..de1f4962f55d6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1073,6 +1073,7 @@ our $Typecast	= qr{\s*(\(\s*$NonptrType\s*\)){0,1}\s*};
 # Any use must be runtime checked with $^V
 
 our $balanced_parens = qr/(\((?:[^\(\)]++|(?-1))*\))/;
+our $balanced_brackets = qr/(\[(?:[^\[\]]++|(?-1))*\])/;
 our $LvalOrFunc	= qr{((?:[\&\*]\s*)?$Lval)\s*($balanced_parens{0,1})\s*};
 our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
 
@@ -4107,7 +4108,7 @@ sub process {
 			# looks like a declaration
 			    !($sl =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
 			# function pointer declarations
-			      $sl =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
+			      $sl =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident(?:\s*$balanced_brackets)*\s*\)\s*[=,;:\[\(]/ ||
 			# foo bar; where foo is some local typedef or #define
 			      $sl =~ /^\+\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
 			# known declaration macros

