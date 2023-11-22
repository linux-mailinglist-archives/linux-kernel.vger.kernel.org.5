Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899107F486B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbjKVOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjKVOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:00:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F63DA9;
        Wed, 22 Nov 2023 06:00:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE673C433C8;
        Wed, 22 Nov 2023 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700661641;
        bh=CKpWtcakXU6WLfkLUYMnK2MftqPDlyVQofJh5L4ipog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfQB384hXCtGbDq3OEp+k+dC8Y95OtcvnToRFARS3SDWJ6KN61NI6F7znWBpzVRZy
         blYNyv3BkMn8/fMRiDzO1wyob3LYygCpQVnZmCWxpglAOIy6qZeHz6EWpbcx6oEnOQ
         ZD1UymrrTktDwQAdyHxQf0fDGf8zTfossoLSeTUZ6pjaVE/PjBDNbDLRKOPWYc+CRb
         2hKNctjCDvzK9jCLYwIjwa14u6LOKRZpaQ5fRQhowQWJhI4nHVL83nQSoBQmUEpRzJ
         XLCy/aOL44CWepHZTKNk0rkoBdAVTaeY3706+7M2UJUp/16I81Xi0ZCKrlm+l+vLC9
         NR+fFXfKYY1/g==
Date:   Wed, 22 Nov 2023 15:00:29 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     j.granados@samsung.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
        fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu
Subject: Re: [PATCH v2 0/4] sysctl: Remove sentinel elements from fs dir
Message-ID: <20231122-undifferenziert-weitschuss-a5d8cc56fbd1@brauner>
References: <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,
Acked-by: Christian Brauner <brauner@kernel.org>
