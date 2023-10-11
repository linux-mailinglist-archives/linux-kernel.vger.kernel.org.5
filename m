Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2E7C5956
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjJKQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjJKQjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:39:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102548F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:39:41 -0700 (PDT)
Date:   Wed, 11 Oct 2023 18:39:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697042379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czixzo5H9lrjEHVPwiEdlDlSNtg3PpSgksRzgfHxAZM=;
        b=eb0gK0lO3rROe0IazF7YQ2QFB/Wsv0rWb21m5CPj6GyANhjJUJIGb8FW2Gnh6AhX9vYME5
        ERpefIHHy/kkcx/9kX0KLmLydNCf0cNz87UQnMtKDLeaxoNbC6EcyZ8/b+RtZ9rzXT5K5P
        OXDO9jF1y+XZ3131MwlirKjdkUZB3UL12hnFlWuyWTvLvnZmk4iGDGxkSyeBSQSf9Zq38A
        k4rz68BhsNDLaE16CzMEKCz3YLXamvqtODn4I7iWymv5fTwpvw3juZzwPrnxmdb7GIluUV
        1t8M2nixQvmo1bEVSILOMIr8ay2hWlpeyIENZi4whaB3HE52ioRAYtVimXM16w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697042379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czixzo5H9lrjEHVPwiEdlDlSNtg3PpSgksRzgfHxAZM=;
        b=CSA+MadGLden/zwcuWGafYowEObjjFT66utIWMQqsCT60byJ/kf8vjjE3lWxaYNZykrSIj
        vBaCiP2fMPbAVbDg==
From:   Nam Cao <namcao@linutronix.de>
To:     drosdeck <edson.drosdeck@gmail.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs:Fix coding style errors and warning
Message-ID: <20231011163937.WfJrCwdP@linutronix.de>
References: <20231011164232.28866-1-edson.drosdeck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011164232.28866-1-edson.drosdeck@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 01:42:32PM -0300, drosdeck wrote:
> Warning found by checkpatch.pl script. Fixes warning replacing printk to
> pr_crit and fixes conding style.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

You are doing too many different things in a single commit. Try
splitting them up: 1 commit change printk -> pr_crit, 1 commit add
brackets, etc.

Best regards,
Nam
