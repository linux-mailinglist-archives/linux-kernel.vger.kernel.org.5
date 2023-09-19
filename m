Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9BE7A602B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjISKwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjISKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:52:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DF8197;
        Tue, 19 Sep 2023 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695120695; x=1726656695;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=phhHv2I8bhp2fLaES1pIOW2/yKxSA+u47qV6/kRzK04=;
  b=RHeYIwjPILtOAvOIVHpK2yuPKqmyCMg2VxXPVsdlKh1gWiRB7UgYgBqn
   wm7JF0F01dwaoN7po/bsRed5ISMz5a26XmGgTh+WL0UDMMXTTZslhxeat
   IdQLNVwO9emGeJ94ThFo6+8nyjsaszji8oXy8pe/LV4D2pokLqtjS3w9j
   UT03ZdFCSFrEmvzAqtfu4O4lgKFq+ZrNll1clamJrlOs/xf0fuhZEarnx
   nVe2889iSkcqBsO1gfiERr03zYg6o+epbxArTIv4l4alPfNtOgmPZGP8/
   BBdqN/y3E2N781cG5jJX/E9biILfQ8m0RFMOqssk0bmG5pppchTLSF9iZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="370225738"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="370225738"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="919827887"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="919827887"
Received: from laichele-mobl1.ger.corp.intel.com ([10.252.38.7])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:51:33 -0700
Date:   Tue, 19 Sep 2023 13:51:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/15] tty: fix kernel-doc for functions in tty.h
In-Reply-To: <6d06e531-6c69-47ca-9832-fac21ce6964c@kernel.org>
Message-ID: <576ae74-19dc-84b5-7e8c-563c9561be5d@linux.intel.com>
References: <20230919085156.1578-1-jirislaby@kernel.org> <20230919085156.1578-10-jirislaby@kernel.org> <6033668f-71cc-b21-a034-a1ff31d7279@linux.intel.com> <ae486636-c075-41d9-9304-b0cfb07c132c@kernel.org> <6d06e531-6c69-47ca-9832-fac21ce6964c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2030825116-1695120695=:1920"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2030825116-1695120695=:1920
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 19 Sep 2023, Jiri Slaby wrote:

> On 19. 09. 23, 12:45, Jiri Slaby wrote:
> > On 19. 09. 23, 12:07, Ilpo Järvinen wrote:
> > > On Tue, 19 Sep 2023, Jiri Slaby (SUSE) wrote:
> > > 
> > > > tty_kref_get() is already included in Documentation, but is not properly
> > > > formatted. Fix this.
> > > > 
> > > > tty_get_baud_rate() is neither properly formatted, nor is included. Fix
> > > > both.
> > > > 
> > > > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > > > ---
> > > >   Documentation/driver-api/tty/tty_ioctl.rst |  3 +++
> > > >   include/linux/tty.h                        | 21 +++++++++------------
> > > >   2 files changed, 12 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/Documentation/driver-api/tty/tty_ioctl.rst
> > > > b/Documentation/driver-api/tty/tty_ioctl.rst
> > > > index 9b0be79fc15e..3ff1ac5e07f1 100644
> > > > --- a/Documentation/driver-api/tty/tty_ioctl.rst
> > > > +++ b/Documentation/driver-api/tty/tty_ioctl.rst
> > > > @@ -5,3 +5,6 @@ TTY IOCTL Helpers
> > > >   =================
> > > >   .. kernel-doc:: drivers/tty/tty_ioctl.c
> > > > +
> > > > +.. kernel-doc:: include/linux/tty.h
> > > > +   :identifiers: tty_get_baud_rate
> > > > diff --git a/include/linux/tty.h b/include/linux/tty.h
> > > > index 59d675f345e9..4b6340ac2af2 100644
> > > > --- a/include/linux/tty.h
> > > > +++ b/include/linux/tty.h
> > > > @@ -390,14 +390,12 @@ int vcs_init(void);
> > > >   extern const struct class tty_class;
> > > >   /**
> > > > - *    tty_kref_get        -    get a tty reference
> > > > - *    @tty: tty device
> > > > + * tty_kref_get - get a tty reference
> > > > + * @tty: tty device
> > > >    *
> > > > - *    Return a new reference to a tty object. The caller must hold
> > > > - *    sufficient locks/counts to ensure that their existing reference
> > > > cannot
> > > > - *    go away
> > > > + * Returns: a new reference to a tty object. The caller must hold
> > > > sufficient
> > > > + * locks/counts to ensure that their existing reference cannot go away
> > > 
> > > Shouldn't this have also Locking: entry instead of hiding the details into
> > > Return?
> > 
> > /me left to fix both in a separate patch.
> 
> Ah, no. The Locking Alan introduced means what _this_ function locks. I am not
> sure we want to extend the meaning to _expected_ locks?

There are plenty of examples with "Must be called with" or "Caller holds"
in Locking. This is for humans anyway so one reading should understand it.


-- 
 i.

--8323329-2030825116-1695120695=:1920--
