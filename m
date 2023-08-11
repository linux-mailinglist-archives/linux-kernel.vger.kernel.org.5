Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE487784A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjHKAsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKAsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:48:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7075412D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:48:19 -0700 (PDT)
Received: from [192.168.5.50] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5026520FD043;
        Thu, 10 Aug 2023 17:48:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5026520FD043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691714898;
        bh=hDl3N8NEYhqIYaBq2i1XZ/rbogBiHXexOAnXUnVkoR8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sOHDARmw6oigon2k1j8O8iQAu7FWlJ7Hb9HdjGs90gdcvSAj+kzwBlVOLsBDXqFeG
         Br9MoXW92FXX63Z87zCUDXVeHh4fmfcZ/awNWDYZ2MF+025o30kaEqQ2hN+UhJOVg7
         9MXhs2vD1Qw++s7cIIHctLOc8OeI0mwuDJ7Z6+nM=
Message-ID: <0dace822-ce13-906e-46bd-e1cb9274cafe@linux.microsoft.com>
Date:   Thu, 10 Aug 2023 17:48:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: pstore/ram: printk: NULL characters in pstore ramoops area
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
 <202308040053.7F38C6D@keescook>
 <0220f601-14f8-1dda-f057-73a608fbe62b@linux.microsoft.com>
 <202308101649.337F4D8@keescook>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <202308101649.337F4D8@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 16:50, Kees Cook wrote:
> Can you share the .config you're building with? And what are you using
> to trigger an Oops? I will see if I can reproduce this...


Config: https://paste.ubuntu.com/p/Vrcsf8Ry9g/

Just ran plain "sudo reboot" and inspected /var/lib/systemd/pstore/dmesg-ramoops-0 after reboot.

Thanks,
Vijay
