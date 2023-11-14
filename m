Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57E7EB32B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjKNPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjKNPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:12:14 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE15116;
        Tue, 14 Nov 2023 07:12:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DB941C000F;
        Tue, 14 Nov 2023 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699974728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4t9RfhMfPasAV/8o1yb+W8h0NYYNv+iy1sxIy2vgOdE=;
        b=bbJNkHU/eoryXTuKg7N/zosxXWrbkys7E6ttT5QXI80bKNUYbVm+WmXivZ3WYkWBEtB6U5
        uoEErM/aVZZ7wjQNeR9qUOs0YPAHQqzbIKr7OA8NV/VT0TkwyWNlq6f6pyRnrb+xyzeROv
        I0VZh4Xo6+1NmcMxA+T3C+TCHU5GqGHM9u/vhi5Y7H85Vqp24QUjKxCFsfz5rGmJEY1W4J
        ecyAZxSl3b1oAs5cN7yJpY9/IgrIkY4biaterVcWdYxVnwkNst6CYBOvq4HzjIGAT42suY
        4eUnw2z1OlolASFLXpeUhmZKXkIIy0CjnliZMzBGl+qc+R15+p/1k8/4T3J/eg==
Date:   Tue, 14 Nov 2023 16:12:05 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Fix %pfwf when current node
 refcount == 0
Message-ID: <20231114161205.07cadeb7@bootlin.com>
In-Reply-To: <ZVOIfXV8al5hiMQD@kekkonen.localdomain>
References: <20231114143558.356259-1-herve.codina@bootlin.com>
        <ZVOIfXV8al5hiMQD@kekkonen.localdomain>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Tue, 14 Nov 2023 14:47:25 +0000
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

[...]

> > +		 * Only get a reference for other nodes (ie parents node).  
> 
> "i.e."

Will be changed in the next iteration.

> 
> With that,
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Best regards,
Hervé
