Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB67BA76C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjJERO2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 13:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjJERN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:13:28 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C5100;
        Thu,  5 Oct 2023 10:03:54 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id ed5fc6d05de824cd; Thu, 5 Oct 2023 19:03:52 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E7D13665C7F;
        Thu,  5 Oct 2023 19:03:51 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com,
        andriy.shevchenko@intel.com, lenb@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/9] ACPI: bus: Make notify wrappers more generic
Date:   Thu, 05 Oct 2023 19:03:51 +0200
Message-ID: <12310703.O9o76ZdvQC@kreacher>
In-Reply-To: <CAJZ5v0jSa7FpJKsDRAhVMGy=pTi-aD5JPU4K3Rb-G3igrd6WRQ@mail.gmail.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com> <86a68f57-0e5e-4a92-8cfe-93249ba78a72@intel.com> <CAJZ5v0jSa7FpJKsDRAhVMGy=pTi-aD5JPU4K3Rb-G3igrd6WRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeggddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkeeileehffelfefggfdtjedvkeettdejfeevueegfedvhffgudeuteeigfeileetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehmihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
 rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvhguihhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehrrghfrggvlhdrjhdrfiihshhotghkihesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 5, 2023 5:30:59 PM CEST Rafael J. Wysocki wrote:
> On Thu, Oct 5, 2023 at 2:05 PM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
> > On 10/5/2023 12:57 PM, Rafael J. Wysocki wrote:
> > > On Thu, Oct 5, 2023 at 10:10 AM Wilczynski, Michal
> > > <michal.wilczynski@intel.com> wrote:
> 
> [cut]
> 
> > >>>
> > >>> That said, why exactly is it better to use acpi_handle instead of a
> > >>> struct acpi_device pointer?
> > >> I wanted to make the wrapper as close as possible to the wrapped function.
> > >> This way it would be easier to remove it in the future i.e if we ever deem
> > >> extra synchronization not worth it etc. What the ACPICA function need to
> > >> install a wrapper is a handle not a pointer to a device.
> > >> So there is no need for a middle man.
> > > Taking a struct acpi_device pointer as the first argument is part of
> > > duplication reduction, however, because in the most common case it
> > > saves the users of it the need to dereference the struct acpi_device
> > > they get from ACPI_COMPANION() in order to obtain the handle.
> >
> > User don't even have to use acpi device anywhere, as he can choose
> > to use ACPI_HANDLE() instead on 'struct device*' and never interact
> > with acpi device directly.
> 
> Have you actually looked at this macro?  It is a wrapper around
> ACPI_COMPANION().
> 
> So they may think that they don't use struct acpi_device pointers, but
> in fact they do.
> 
> > >
> > > Arguably, acpi_handle is an ACPICA concept and it is better to reduce
> > > its usage outside ACPICA.
> >
> > Use of acpi_handle is deeply entrenched in the kernel. There is even
> > a macro ACPI_HANDLE() that returns acpi_handle. I would say it's
> > way too late to limit it to ACPICA internal code.
> 
> So there is a difference between "limiting to ACPICA" and "reducing".
> It cannot be limited to ACPICA, because the code outside ACPICA needs
> to evaluate ACPI objects sometimes and ACPI handles are needed for
> that.
> 
> And this observation doesn't invalidate the point.
> 
> > >
> > >>> Realistically, in a platform driver you'll need the latter to obtain
> > >>> the former anyway.
> > >> I don't want to introduce arbitrary limitations where they are not necessary.
> > > I'm not sure what you mean.  This patch is changing existing functions.
> >
> > That's true, but those functions aren't yet deeply entrenched in the
> > kernel yet, so in my view how they should look like should still be
> > a subject for discussion, as for now they're only used locally in
> > drivers/acpi, and my next patchset, that would remove .notify in
> > platform directory would spread them more, and would
> > make them harder to change. For now we can change how they
> > work pretty painlessly.
> 
> I see no particular reason to do that, though.
> 
> What specifically is a problem with passing struct acpi_device
> pointers to the wrappers?  I don't see any TBH.
> 
> > >
> > >> It is often the case that driver allocates it's own private struct using kmalloc
> > >> family of functions, and that structure already contains everything that is
> > >> needed to remove the handler, so why force ? There are already examples
> > >> in the drivers that do that i.e in acpi_video the function
> > >> acpi_video_dev_add_notify_handler() uses raw ACPICA handler to install
> > >> a notify handler and it passes private structure there.
> > >> So there is value in leaving the choice of an actual type to the user of the
> > >> API.
> > > No, if the user has a pointer to struct acpi_device already, there is
> > > no difference between passing this and passing the acpi_handle from it
> > > except for the extra dereference in the latter case.
> >
> > Dereference would happen anyway in the wrapper, and it doesn't cause
> > any harm anyway for readability in my opinion. And of course you don't
> > have to use acpi device at all, you can use ACPI_HANDLE() macro.
> 
> So one can use ACPI_COMPANION() just as well and it is slightly less overhead.
> 
> > >
> > > If the user doesn't have a struct acpi_device pointer, let them use
> > > the raw ACPICA handler directly and worry about the synchronization
> > > themselves.
> >
> > As mentioned acpi_device pointer is not really required to use the wrapper.
> > Instead we can use ACPI_HANDLE() macro directly. Look at the usage of
> > the wrapper in the AC driver [1].
> 
> You don't really have to repeat the same argument  several times and I
> know how ACPI_HANDLE() works.  Also I don't like some of the things
> done by this patch.
> 
> Whoever uses ACPI_HANDLE(), they also use ACPI_COMPANION() which is
> hidden in the former.
> 
> If they don't need to store either the acpi_handle or the struct
> acpi_device pointer, there is no reason at all to use the former
> instead of the latter.
> 
> If they get an acpi_handle from somewhere else than ACPI_HANDLE(),
> then yes, they would need to get the ACPI devices from there (which is
> possible still), but they may be better off by using the raw ACPICA
> interface for events in that case.
> 
> > -static void acpi_ac_remove(struct acpi_device *device)
> > +static void acpi_ac_remove(struct platform_device *pdev)
> >  {
> > -       struct acpi_ac *ac = acpi_driver_data(device);
> > +      struct acpi_ac *ac = platform_get_drvdata(pdev);
> >
> > -       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
> > +       acpi_dev_remove_notify_handler(ACPI_HANDLE(ac->dev),
> > +                                                                     ACPI_ALL_NOTIFY,
> >                                                                        acpi_ac_notify);
> >
> >
> >
> > [1] - https://lore.kernel.org/all/20230925144842.586829-1-michal.wilczynski@intel.com/T/#mff1e8ce1e548b3252d896b56d3be0b1028b7402e
> >
> > >
> > > The wrappers are there to cover the most common case, not to cover all cases.
> >
> > In general all drivers that I'm modifying would benefit from not using direct ACPICA
> > installers/removers by saving that extra synchronization code that would need to be
> > provided otherwise, and not having to deal with acpi_status codes.
> 
> Yes, that's the common case.
> 
> >
> > >
> > >> To summarize:
> > >> I would say the wrappers are mostly unnecessary, but they actually save
> > >> some duplicate code in the drivers, so I decided to leave them, as I don't
> > >> want to introduce duplicate code if I can avoid that.
> > > What duplicate code do you mean, exactly?
> >
> > I would need to declare extra acpi_status variable and use ACPI_FAILURE macro
> > in each usage of the direct ACPICA installer. Also I would need to call
> > acpi_os_wait_events_complete() after calling each direct remove.
> 
> I thought you meant some code duplication related to passing struct
> acpi_device pointers to the wrappers, but we agree that the wrappers
> are generally useful.
> 
> > >
> > > IMV you haven't really explained why this particular patch is
> > > necessary or even useful.
> >
> > Maybe using an example would better illustrate my point.
> > Consider using NFIT driver modification later in this series as an example:
> >
> > 1) With old wrapper it would look:
> >
> >  static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
> > {
> >     struct acpi_device *adev = data;
> >     /* Now we need to figure how to get a 'struct device*' from an acpi_device.
> >          Mind this we can't just do &adev->dev, as we're not using that device anymore.
> >          We need to get a struct device that's embedded in the platform_device that the
> >          driver was instantiated with.
> >          Not sure how it would look like, but it would require are least one extra line here.
> >      */
> >     device_lock(dev);
> >     __acpi_nfit_notify(dev, handle, event);
> >     device_unlock(dev);
> > }
> >
> > 2) With new wrapper:
> >
> > static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
> > {
> >     struct device *dev = data;
> >
> >     device_lock(dev);
> >     __acpi_nfit_notify(dev, handle, event);
> >     device_unlock(dev);
> > }
> >
> >
> > So essentially arbitrarily forcing user to use wrapper that takes acpi device
> > as an argument may unnecessarily increase drivers complexity, and if we
> > can help with then we should. That's why this commit exists.
> 
> Well, I know what's going on now.
> 
> You really want to add a context argument to
> acpi_dev_install_notify_handler(), which is quite reasonable, but then
> you don't have to change the first argument of it.
> 
> I'll send you my version of this patch later today and we'll see.

See below.

It just adds a context argument to acpi_dev_install_notify_handler() without
making the other changes made by the original patch that are rather pointless
IMO.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1 1/9] ACPI: bus: Add context argument to acpi_dev_install_notify_handler()

Add void *context arrgument to the list of arguments of
acpi_dev_install_notify_handler() and modify it to pass that argument
as context to acpi_install_notify_handler() instead of its first
argument which is problematic in general (for example, if platform
drivers used it, they would rather get struct platform_device pointers
or pointers to their private data from the context arguments of their
notify handlers).

Make all of the current callers of acpi_dev_install_notify_handler()
take this change into account so as to avoid altering the general
functionality.

Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c         |    2 +-
 drivers/acpi/acpi_video.c |    2 +-
 drivers/acpi/battery.c    |    2 +-
 drivers/acpi/bus.c        |    4 ++--
 drivers/acpi/hed.c        |    2 +-
 drivers/acpi/nfit/core.c  |    2 +-
 drivers/acpi/thermal.c    |    2 +-
 include/acpi/acpi_bus.h   |    2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/ac.c
===================================================================
--- linux-pm.orig/drivers/acpi/ac.c
+++ linux-pm/drivers/acpi/ac.c
@@ -257,7 +257,7 @@ static int acpi_ac_add(struct acpi_devic
 	register_acpi_notifier(&ac->battery_nb);
 
 	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_ac_notify);
+						 acpi_ac_notify, device);
 	if (result)
 		goto err_unregister;
 
Index: linux-pm/drivers/acpi/acpi_video.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_video.c
+++ linux-pm/drivers/acpi/acpi_video.c
@@ -2062,7 +2062,7 @@ static int acpi_video_bus_add(struct acp
 		goto err_del;
 
 	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						acpi_video_bus_notify);
+						acpi_video_bus_notify, device);
 	if (error)
 		goto err_remove;
 
Index: linux-pm/drivers/acpi/battery.c
===================================================================
--- linux-pm.orig/drivers/acpi/battery.c
+++ linux-pm/drivers/acpi/battery.c
@@ -1214,7 +1214,7 @@ static int acpi_battery_add(struct acpi_
 	device_init_wakeup(&device->dev, 1);
 
 	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_battery_notify);
+						 acpi_battery_notify, device);
 	if (result)
 		goto fail_pm;
 
Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -556,12 +556,12 @@ static void acpi_device_remove_notify_ha
 
 int acpi_dev_install_notify_handler(struct acpi_device *adev,
 				    u32 handler_type,
-				    acpi_notify_handler handler)
+				    acpi_notify_handler handler, void *context)
 {
 	acpi_status status;
 
 	status = acpi_install_notify_handler(adev->handle, handler_type,
-					     handler, adev);
+					     handler, context);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
Index: linux-pm/drivers/acpi/hed.c
===================================================================
--- linux-pm.orig/drivers/acpi/hed.c
+++ linux-pm/drivers/acpi/hed.c
@@ -57,7 +57,7 @@ static int acpi_hed_add(struct acpi_devi
 	hed_handle = device->handle;
 
 	err = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-					      acpi_hed_notify);
+					      acpi_hed_notify, device);
 	if (err)
 		hed_handle = NULL;
 
Index: linux-pm/drivers/acpi/nfit/core.c
===================================================================
--- linux-pm.orig/drivers/acpi/nfit/core.c
+++ linux-pm/drivers/acpi/nfit/core.c
@@ -3391,7 +3391,7 @@ static int acpi_nfit_add(struct acpi_dev
 		return rc;
 
 	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					     acpi_nfit_notify);
+					     acpi_nfit_notify, adev);
 	if (rc)
 		return rc;
 
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -936,7 +936,7 @@ static int acpi_thermal_add(struct acpi_
 		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temp_dk));
 
 	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						 acpi_thermal_notify);
+						 acpi_thermal_notify, device);
 	if (result)
 		goto flush_wq;
 
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -601,7 +601,7 @@ int acpi_bus_attach_private_data(acpi_ha
 void acpi_bus_detach_private_data(acpi_handle);
 int acpi_dev_install_notify_handler(struct acpi_device *adev,
 				    u32 handler_type,
-				    acpi_notify_handler handler);
+				    acpi_notify_handler handler, void *context);
 void acpi_dev_remove_notify_handler(struct acpi_device *adev,
 				    u32 handler_type,
 				    acpi_notify_handler handler);



