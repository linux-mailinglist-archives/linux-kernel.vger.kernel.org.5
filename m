Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60C6810B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378731AbjLMHId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378741AbjLMHIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:08:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5048A10F6;
        Tue, 12 Dec 2023 23:07:38 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 044311FD3F;
        Wed, 13 Dec 2023 07:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702451255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJOlmOmE3PzQGnQ8ocTXIGBDJbf58crbhAN4KywhWFI=;
        b=AxlkX29+0ZaRsy5BU0l52rVoyS38/kiOfDMV/d3JWZZ3EeTrE5VHg/bSsZnx3/CbZNl9LW
        e5EU0pW5ev86EQWqVnDsZRdPVR03lI/EHwpnrzo00R64cmRZ/DR2QG8AzM+i6y+gxgs5AS
        SS8Ax7zFt+VBDHZmqmBH0HnkfHw/bVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702451255;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJOlmOmE3PzQGnQ8ocTXIGBDJbf58crbhAN4KywhWFI=;
        b=yEgpp1hiJjvEWXbPFbGIj9V6xjmFg+kYbj6n+8s8HgRUXzbK6dm4vr6PeHgTVW6/4XcKxZ
        +b6NxBzyew2NRsAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702451255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJOlmOmE3PzQGnQ8ocTXIGBDJbf58crbhAN4KywhWFI=;
        b=AxlkX29+0ZaRsy5BU0l52rVoyS38/kiOfDMV/d3JWZZ3EeTrE5VHg/bSsZnx3/CbZNl9LW
        e5EU0pW5ev86EQWqVnDsZRdPVR03lI/EHwpnrzo00R64cmRZ/DR2QG8AzM+i6y+gxgs5AS
        SS8Ax7zFt+VBDHZmqmBH0HnkfHw/bVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702451255;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJOlmOmE3PzQGnQ8ocTXIGBDJbf58crbhAN4KywhWFI=;
        b=yEgpp1hiJjvEWXbPFbGIj9V6xjmFg+kYbj6n+8s8HgRUXzbK6dm4vr6PeHgTVW6/4XcKxZ
        +b6NxBzyew2NRsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3D4E1377F;
        Wed, 13 Dec 2023 07:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id rECYIjZYeWWmHAAAD6G6ig
        (envelope-from <hare@suse.de>); Wed, 13 Dec 2023 07:07:34 +0000
Message-ID: <6a83affa-c2b0-4236-92f6-354bb0c7f5de@suse.de>
Date:   Wed, 13 Dec 2023 08:07:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: fcoe: use sysfs_match_string over
 fcoe_parse_mode
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231212-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v2-1-1f2d6b2fc409@google.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231212-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v2-1-1f2d6b2fc409@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -0.97
X-Spam-Level: 
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 044311FD3F
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
        dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AxlkX29+;
        dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yEgpp1hi;
        dmarc=pass (policy=none) header.from=suse.de;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Spamd-Result: default: False [-9.89 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_TRACE(0.00)[suse.de:+];
         DMARC_POLICY_ALLOW(0.00)[suse.de,none];
         RCPT_COUNT_SEVEN(0.00)[7];
         MX_GOOD(-0.01)[];
         DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.09)[64.76%];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         WHITELIST_DMARC(-7.00)[suse.de:D:+];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -9.89
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/23 00:19, Justin Stitt wrote:
> Instead of copying @buf into a new buffer and carefully managing its
> newline/null-terminating status, we can just use sysfs_match_string()
> as it uses sysfs_streq() internally which handles newline/null-term:
> 
> |  /**
> |   * sysfs_streq - return true if strings are equal, modulo trailing newline
> |   * @s1: one string
> |   * @s2: another string
> |   *
> |   * This routine returns true iff two strings are equal, treating both
> |   * NUL and newline-then-NUL as equivalent string terminations.  It's
> |   * geared for use with sysfs input strings, which generally terminate
> |   * with newlines but are compared against values without newlines.
> |   */
> |  bool sysfs_streq(const char *s1, const char *s2)
> |  ...
> 
> Then entirely drop the now unused fcoe_parse_mode, being careful to
> change if condition from checking for FIP_CONN_TYPE_UNKNOWN to < 0 as
> sysfs_match_string can return -EINVAL. Also check explicitly if
> ctlr->mode is equal to FIP_CONN_TYPE_UNKNOWN -- this is probably
> preferred to "<=" as the behavior is more obvious while maintaining
> functionality.
> 
> To get the compiler not to complain, make fip_conn_type_names
> const char * const. Perhaps, this should also be done for
> fcf_state_names.
> 
> This also removes an instance of strncpy() which helps [1].
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - update if-cond to check for unknown type (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20231211-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v1-1-73b942238396@google.com
> ---
> Builds upon patch and feedback from [2]:
> 
> However, this is different enough to warrant its own patch and not be a
> continuation.
> 
> [2]: https://lore.kernel.org/all/9f38f4aa-c6b5-4786-a641-d02d8bd92f7f@acm.org/
> ---
>   drivers/scsi/fcoe/fcoe_sysfs.c | 26 ++++----------------------
>   1 file changed, 4 insertions(+), 22 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

